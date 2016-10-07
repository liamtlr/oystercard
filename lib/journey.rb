require_relative 'station'

class Journey

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      @fare = Oystercard::PENALTY_FARE
    else
      @fare = 1 + calc_zone_difference
    end
  end

  def return_journey_hash
    {entry_station: @entry_station, exit_station: @exit_station, fare: fare}
  end

  private

  def calc_zone_difference
    a, b = [@entry_station.zone, @exit_station.zone].sort
    b - a
  end


end
