require 'oystercard'

describe Oystercard do
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

end