require 'oystercard'

class Chocolate

  attr_reader :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def start_journey(entry_station)
  end
end
