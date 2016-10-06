require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journeys  = []
    @journey_class = journey_class
  end

  def start(station)
    current_journey_method
    @current_journey.entry_station = station
    @journeys << @current_journey
  end

  def finish(station)
    current_journey_method
    @current_journey.exit_station = station
    @journeys << @current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey_method
    @current_journey ||= @journey_class.new
  end

end
