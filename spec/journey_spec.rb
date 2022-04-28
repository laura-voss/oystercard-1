require 'journey'

describe Journey do

  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe '#begin' do
    it 'begins a journey' do
      subject.begin(:entry_station)
      expect(subject.in_journey?).to eq(true)
    end
  end

  describe '#end' do 
    it 'completes the journey' do
      subject.begin(:entry_station)
      subject.end(:exit_station)
      expect(subject.in_journey?).to eq(false)
    end

    it 'saves the completed journey' do
      subject.begin(:entry_station)
      subject.end(:exit_station)
      expect(subject.complete_journey).to eq({in: :entry_station, out: :exit_station})
    end
  end

  describe '#calculate_fare' do
    it 'calculates the minimum fare when a journey is complete' do
      subject.begin(:entry_station)
      subject.end(:exit_station)
      expect(subject.calculate_fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'calculates the penalty when touching in while in a journey' do
      subject.begin(:entry_station)
      subject.begin(:entry_station)
      expect(subject.calculate_fare).to eq(Journey::PENALTY_FARE)
    end

    it 'calculates the penalty when touching out while not in a journey' do
      subject.end(:exit_station)
      expect(subject.calculate_fare).to eq(Journey::PENALTY_FARE)
    end
  end
   
end