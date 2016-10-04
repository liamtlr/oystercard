require 'journey'

describe Journey do

  let(:station) { double :station, zone: 1 }
  let(:exit_station) { double :station, zone: 1 }
  let(:oystercard) { double :oystercard, entry_station: station }


  context 'given an entry station' do
    subject {described_class.new(station)}

    it 'has entry station' do
      expect(subject.entry_station).to eq station
  end
end
end

  #
  # describe '#journey_history'
  # it 'receives information on journey history' do
  #   allow(oystercard).to receive(:touch_out)
  #   journey_history = []
  #   journey_hash = { station: station, exit_station: exit_station }
  #   oystercard.touch_out(exit_station)
  #   expect(subject.journey_history.last).to eq journey_hash
