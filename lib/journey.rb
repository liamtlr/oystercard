require_relative 'oystercard'

class Journey
MIN_FARE = 3
PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :stations, :fare

  def initialize(station)
    @entry_station = station
    @fare = PENALTY_FARE
    @stations = {}

  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @fare = MIN_FARE if complete?
  end

  def stations

    {entrystation: @entry_station[:name], exitstation: "Unknown"} if @exit_station.nil?
    {entrystation: @entry_station["Unknown"], exitstation: [:name]} if @entry_station.nil?
    {entrystation: @entry_station[:name], exitstation: @exit_station[:name]}
  end

  def complete?
    !!@exit_station
  end

  def fare
    @fare = MIN_FARE if complete?
    @fare
  end

end
