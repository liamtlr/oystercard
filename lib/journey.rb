require_relative 'oystercard'

class Journey
MIN_FARE = 3
PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize(station)
    @entry_station = station
    @fare = PENALTY_FARE
    @stations = {}
  end

  def end_journey(exit_station = "unknown")
    @fare = MIN_FARE if complete?
    @exit_station = exit_station
  end

  def stations
    {entry_station: exit_station}
  end

  def complete?
    !!@exit_station
  end

  def fare
    @fare = MIN_FARE if complete?
    @fare
  end

end
