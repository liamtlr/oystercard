require 'journey'
require 'oystercard'

describe Journey do

  let(:waterloo) { double :station, :name => "waterloo", :zone => 1}
  let(:stockwell) { double :station, :name => "stockwell", :zone => 1}

  describe '#initialize' do

    it 'has a default entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end
  end

  context 'given an entry station' do

    subject {described_class.new(stockwell, waterloo)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq stockwell
    end
  end

  describe '#fare' do
    it 'charges MINIMUM_FARE for a complete trip' do
      test_journey = described_class.new(waterloo, stockwell)
      expect(test_journey.fare).to eq(Oystercard::MINIMUM_FARE)
    end

    it 'charges PENALTY_FARE for not touching out of previous trip' do
      described_class.new(entry_station = "station")
      expect(subject.fare).to eq(Oystercard::PENALTY_FARE)
    end

    it 'charges PENALTY_FARE for not touching in' do
      described_class.new
      expect(subject.fare).to eq(Oystercard::PENALTY_FARE)
    end

  end
end
