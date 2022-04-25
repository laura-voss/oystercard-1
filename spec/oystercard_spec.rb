require 'oystercard'

describe Oystercard do
  it 'initializes new card' do
    expect(Oystercard.new).to be_an_instance_of(Oystercard)
  end

  it 'sets new card to 0 balance' do 
    new_oyster = Oystercard.new
    expect(new_oyster.balance).to eq(0)
  end
end