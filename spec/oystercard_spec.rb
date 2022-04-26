require 'oystercard'

describe Oystercard do
  
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  
  it 'initializes new card' do
    expect(Oystercard.new).to be_an_instance_of(Oystercard)
  end

  # Top-up
  describe '#top_up' do
    it 'sets new card to 0 balance' do 
      expect(subject.balance).to eq(0)
    end

    it "tops up card with balance" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'raises an error if the maximum balance it exceeded' do
      maximum_balance = Oystercard::MAXIMUM_CAPACITY
      subject.top_up maximum_balance
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  # Touch_in
  describe '#touch_in' do
    it 'responds to touch_in method' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'changes in_journey? to true' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect(subject.in_journey?).to be true
    end

    it 'raises error if card touched_in twice' do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect{subject.touch_in(:entry_station)}.to raise_error 'Oyster already touched in'
    end

    it "raises error when trying to touch_in with less than £1" do
      expect { subject.touch_in(entry_station) }.to raise_error "Not enough funds"
    end
  end

  # Touch_out
  describe '#touch_out' do
    it 'responds to touch_out method' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'changes in_journey? to false' do
      expect(subject.in_journey?).to be false
    end

    it 'rasises error at touch_out if card not in_journey?' do
      expect{subject.touch_out(:exit_station)}.to raise_error 'Oyster not touched in' 
    end

    it "deducts £1" do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::FARE)
    end
  end

  # Journey
  describe '#journey' do
    it "responds to #journey" do
      expect(subject).to respond_to :journey
    end

    it "creates a hash with the journey" do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.journey).to eq ({in: :entry_station, out: :exit_station})
    end

    xit 'pushes the journey hash to the journey_history array after touch in' do
    end

    xit 'resets the journey hash to nil after touch out' do
    end

  end
end