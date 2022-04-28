require 'station'

describe Station do

  subject {described_class.new(name: "Bow", zone: 2)}

  describe '#zone' do
    it 'returns the zone the station is in' do
      expect(subject.zone).to eq(2)
    end
  end

  describe '#name' do
    it 'returns the station name' do
      expect(subject.name).to eq("Bow")
    end
  end
end


