require 'oystercard'

describe Oystercard do
  
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  
  it 'initializes new card' do
    expect(Oystercard.new).to be_an_instance_of(Oystercard)
  end

  it 'sets new card to 0 balance' do 
    new_oyster = Oystercard.new
    expect(new_oyster.balance).to eq(0)
  end

  it "tops up card with balance" do
    oyster = Oystercard.new
    oyster.top_up(10)
    expect(oyster.balance).to eq(10)
  end

  it 'raises an error if the maximum balance it exceeded' do
    maximum_balance = Oystercard::MAXIMUM_CAPACITY
    subject.top_up maximum_balance
    expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
  end

  # it "responds to deduct method" do
  #   expect(Oystercard.new).to respond_to(:deduct).with(1).argument
  # end

  # it "deducts fare from balance" do
  #   oyster = Oystercard.new
  #   oyster.top_up(70)
  #   oyster.deduct(10)
  #   expect(oyster.balance).to eq(60)
  # end

  it 'responds to touch_in method' do
    expect(Oystercard.new).to respond_to(:touch_in).with(1).argument
  end

  it 'status changes to in_use when card touched in' do
    oyster = Oystercard.new
    oyster.top_up(1)
    oyster.touch_in(entry_station)
    expect(oyster.in_journey?).to be_truthy
  end

  it 'responds to touch_out method' do
    expect(Oystercard.new).to respond_to(:touch_out).with(1).argument
  end

  it 'status changes to not_in_use when card touched out' do
    oyster = Oystercard.new
    expect(oyster.in_journey?).to be_falsy
  end

  it 'raises error at touch_in if card already in use' do
    oyster = Oystercard.new
    oyster.top_up(1)
    oyster.touch_in(entry_station)
    expect(oyster).to be_in_journey
  end

  it 'rasises error at touch_out if card is not in use' do
    oyster = Oystercard.new
    expect(oyster).not_to be_in_journey
  end

  it "raises error when trying to touch_in with less than gbp1" do
    expect { subject.touch_in(entry_station) }.to raise_error "Not enough funds"
  end

  it "deducts £1 on touch-out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-(Oystercard::FARE))
  end

  it "remembers entry station after touch_in" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq(entry_station)
  end

  it "forgets entry station after touch_out" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.entry_station).to be(nil)
  end

  it "shows the exit station on touch-out" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it "responds to #journey" do
    expect(subject).to respond_to :journey
  end

  it "creates a hash with the journey" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey).to eq ({in: entry_station, out: exit_station})
  end

end