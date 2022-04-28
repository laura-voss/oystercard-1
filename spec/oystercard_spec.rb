require 'oystercard'

describe Oystercard do
  
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe '#top_up' do
    it 'sets new card to 0 balance' do 
      expect(subject.balance).to eq(0)
    end

    it "tops up card with balance" do
      expect{ subject.top_up(10)}.to change{subject.balance}.by(10)
    end

    it 'raises an error if the maximum balance it exceeded' do
      maximum_balance = Oystercard::MAXIMUM_CAPACITY
      subject.top_up maximum_balance
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do
    
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

  describe '#touch_out' do

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

  describe '#journey' do

    it 'resets the journey hash to nil after touch out' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.journey).to eq ({})
    end

    it 'pushes the journey hash to the journey_history array after touch in' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.journey_history).to include({in: :entry_station, out: :exit_station})
    end
  end
end