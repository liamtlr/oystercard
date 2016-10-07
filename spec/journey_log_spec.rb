require 'journey_log'

describe JourneyLog do

  journey = Journey.new
=begin
  it "should initialise with a journey_class parameter" do
    expect(described_class.new(journey).class).to eq JourneyLog
  end
=end

  it {is_expected.to respond_to :start }
end
