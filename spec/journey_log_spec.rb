require 'journey_log'

describe JourneyLog do

  journey = Journey.new

  subject {described_class.new(journey)}
  let(:waterloo) { double :station }
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
end
