require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

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

  def charge
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
