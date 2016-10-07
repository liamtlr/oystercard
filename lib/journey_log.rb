require 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station

  def initialize(journey_class=Journey)

  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  private

  def current_journey
    @current_journey ||= journey_class.new
  end

end
