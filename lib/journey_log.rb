require_relative 'journey'

class JourneyLog

  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def start(station)
    @journey = Journey.new(station, nil)
    @journeys << @journey
  end

  def finish(station)
    @journey.exit_station = station
  end

  def journeys
    @journeys
  end

  private

  def current_journey


  end

end
