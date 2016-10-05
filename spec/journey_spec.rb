require 'journey'



describe Journey do

  let(:station) {double(:station, name: 'Old Street', zone: 1)}
  let(:exit_station) {double :station, name: 'Kentish Town', zone: 2}
  let(:subject) {described_class.new(station)}

  describe '#initialize' do
    it 'receives an entry station' do
    expect(subject.entry_station).to eq station
  end
  end

  describe '#end_journey' do
    it 'receives an exit station' do
      subject.end_journey(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#complete?' do
    it 'knows journey is complete' do
    subject.end_journey(exit_station)
    expect(subject.complete?).to eq true
  end
  it 'knows journey is incomplete' do
    expect(subject.complete?).to eq false
  end
end

  describe '#charge' do
    it 'applies a penalty charge if the journey is incomplete' do
    expect(subject.charge). to eq penalty_fare
  end
end

end
