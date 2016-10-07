require_relative 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station

  def initialize(journey_class=Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
    @current_journey.
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def journeys

  end

  private

  def current_journey
    @current_journey ||= journey_class.new
  end

end
