require 'journey_log'

describe JourneyLog do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  let(:journey_class){double :journey_class, new: journey}
  # subject {described_class.new(journey_class: journey_class)}




  describe "#start" do

    it 'puts something in the journeys array' do
      subject.start(entry_station)
      expect(subject.journeys.count).to eq 1
    end

    it 'puts an actual journey in the journeys array' do
      subject.start(entry_station)
      expect(subject.current_journey.entry_station).to eq entry_station
    end

    # it 'starts a journey' do
    #   expect(journey_class).to receive(:new).with(entry_station: entry_station)
    #   subject.start(entry_station)
    # end

    # it 'records a journey' do
    #   allow(journey_class).to receive(:new).and_return journey
    #   subject.start(entry_station)
    #   expect(subject.journeys).to include journey
    # end


  end

  describe "#finish" do

    it 'adds an exit station to the current journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys.last.exit_station).to eq exit_station
    end
    # it 'resets the current journey' do
    #   subject.start(entry_station)
    #   subject.finish(exit_station)
    #   expect(subject.current_journey).to be_nil
    # end
  end

end
