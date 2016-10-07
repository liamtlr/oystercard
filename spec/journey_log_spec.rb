require 'journey_log'

describe JourneyLog do

    journey = Journey.new

    subject {described_class.new(journey)}
    let(:waterloo) { double :station }
    let(:stockwell) { double :station }
    let(:journey) { double :journey }
=begin
  it "should initialise with a journey_class parameter" do
    expect(described_class.new(journey).class).to eq JourneyLog
  end
=end

  it {is_expected.to respond_to :start }

  describe '#start' do
    it 'starts a new journey' do
      subject.start(waterloo)
      expect(subject.entry_station).to eq waterloo
    end
  end

  describe "#finish" do
    it "should add an exit station to the current_journey" do
      subject.start(waterloo)
      subject.finish(stockwell)
      expect(subject.exit_station).to eq stockwell
    end
  end

  describe '#journeys' do
    it "records journeys" do
      subject.start(waterloo)
      subject.finish(stockwell)
      expect(subject.journeys).to include journey
    end
  end

end
