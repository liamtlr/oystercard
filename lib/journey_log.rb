require_relative 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station

  def initialize(journey_class: Journey )
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
    current_journey(entry_station)
  end

  def finish(exit_station)
    @exit_station = exit_station
    @current_journey.end(exit_station)
    @journeys << @current_journey.return_journey_hash
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey(entry_station)
    @current_journey ||= @journey_class.new(entry_station)
  end

end
