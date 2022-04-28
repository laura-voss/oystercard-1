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

    it "raises error when trying to touch_in with less than £1" do
      expect { subject.touch_in(entry_station) }.to raise_error "Not enough funds"
    end

    it "raises a penalty when already in a journey" do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      expect{ subject.touch_in(:entry_station) }.to change{subject.balance}.by(-Journey::PENALTY_FARE)
    end

  end

  describe '#touch_out' do
    it "reduce the balance on the card by 1 for a successful journey" do
      subject.top_up(1)
      subject.touch_in(:entry_station)
      expect{subject.touch_out(:exit_station)}.to change{subject.balance}.by(-Journey::MINIMUM_FARE)
    end

    it "Charges the penalty when touching out while not in a journey" do
      subject.top_up(50)
      expect{subject.touch_out(:exit_station)}.to change{subject.balance}.by(-Journey::PENALTY_FARE)
    end
  end

  describe '#journey_history' do

    it 'should contain a record of a completed journey' do
      subject.top_up(10)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
      expect(subject.journey_history).to include({in: :entry_station, out: :exit_station})
    end
  end
end