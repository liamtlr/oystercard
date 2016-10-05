require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !!@exit_station 
  end

end

#Journey - start journey
#Journey - end journey
#calculate fare (using entry zone + exit zone)
#journey complete?
