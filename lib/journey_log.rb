require_relative 'journey'

class JourneyLog

    attr_reader :current_journey

  def initialize(journey_class = Journey.new)
    @current_journey
    @journeys  = []
    @journey_class = journey_class
  end

  def start(station)
    current_journey_method(station)
    @journeys << @current_journey
  end

  def finish(station)
    @current_journey.exit_station = station
    @current_journey = nil
  end

  def journeys
    @journeys
  end


  private

  def current_journey_method(station)
    @current_journey ||= Journey.new(station, nil)
  end

end
