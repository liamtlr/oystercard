require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station

  end

  def complete?
    @entry_station && @exit_station
  end

  def charge
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
