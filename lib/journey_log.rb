require 'journey'

class JourneyLog
  attr_reader :entry_station

  def initialize(journey_class=Journey.new)

  end

  def start(entry_station)
    @entry_station = entry_station
  end

end
