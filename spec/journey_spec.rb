require 'journey'

describe Journey do

  penalty_fare = Journey::PENALTY_FARE
  minimum_fare = Journey::MINIMUM_FARE

   let(:station) {double(:station, name: 'Old Street', zone: 1)}

  describe '#initialize' do
    it 'defaults entry station to nil' do
    expect(subject.entry_station).to eq nil
  end
  it 'defaults entry station to nil' do
    expect(subject.exit_station).to eq nil
  end
  end

  describe '#end_journey' do
  end

  describe '#complete?' do
    it 'knows journey is complete' do
    subject.entry_station = "Bristol"
    subject.exit_station = "Moorgate"
    expect(subject).to be_complete
  end
  it 'knows journey is incomplete' do
    subject.entry_station = station
    expect(subject).not_to be_complete
  end
  it 'knows journey is incomplete' do
    subject.exit_station = station
    expect(subject).not_to be_complete
  end
end

  describe '#charge' do
    it 'applies a penalty charge if the journey is incomplete' do
      expect(subject.charge).to eq penalty_fare
    end
    it 'applies the standard fare if the journey is complete' do
      subject.entry_station = "Bristol"
      subject.exit_station = "Moorgate"
      expect(subject.charge).to eq minimum_fare
    end

  end

end
