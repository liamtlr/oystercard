require 'spec_helper'

describe Station do

  station = Station.new('Oxford St', 1)

  it 'has a station name' do
    expect(station.name).to eq 'Oxford St'
  end

  it 'Station has a zone' do
    expect(station.zone).to eq 1
  end

end
