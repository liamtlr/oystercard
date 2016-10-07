require 'journey_log'

describe JourneyLog do
    let(:journey) { double :journey }
    subject {described_class.new}
    let(:waterloo) { double :station }
    let(:stockwell) { double :station }

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
    
    it "resets the entry station" do
      subject.start(waterloo)
      subject.finish(stockwell)
      expect(subject.entry_station).to eq nil
    end

    it "resets the exit station" do
      subject.start(waterloo)
      subject.finish(stockwell)
      expect(subject.exit_station).to eq nil
    end
  end

  describe '#journeys' do
    it "records journeys" do
      journey = {entry_station: waterloo, exit_station: stockwell, fare: Oystercard::MINIMUM_FARE}
      subject.start(waterloo)
      subject.finish(stockwell)
      expect(subject.journeys).to include journey
    end
  end

end
