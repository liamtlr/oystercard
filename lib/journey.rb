require_relative 'oystercard'

class Journey

attr_reader :entry_station

DEFAULT_STATION = nil

def initialize(entry_station = DEFAULT_STATION)
  @entry_station = entry_station
end

  # def collect_journey_history(exit_station)
  #   journey_hash = { :station => @entry_station, :exit_station =>  exit_station }
  #   @journey_history << journey_hash
  # end

end
