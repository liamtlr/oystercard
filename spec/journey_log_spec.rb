require 'journey_log'

describe JourneyLog do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'responds to start' do
    expect(subject).to respond_to(:start).with(1).argument
  end

  it 'responds to finish' do
    expect(subject).to respond_to(:finish).with(1).argument
  end

  it 'responds to journeys' do
    expect(subject).to respond_to(:journeys)
  end

  describe "#start" do

    it 'puts something in the journeys array' do
      subject.start(entry_station)
      expect(subject.journeys.count).to eq 1
    end

    it 'puts an actual journey in the journeys array' do
      subject.start(entry_station)
      expect(subject.journeys.last).to be_an_instance_of Journey
    end

  end

  describe "#finish" do

    it 'adds an exit station to the current journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys.last.exit_station).to eq exit_station
    end

  end

end
