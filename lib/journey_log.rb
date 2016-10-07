require_relative 'journey'
require_relative 'oystercard'

class JourneyLog
  attr_reader :entry_station, :exit_station, :current_journey

  def initialize(journey_class: Journey )
    @journey_class = journey_class
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    @entry_station = entry_station
    current_journey_method(entry_station)
  end

  def finish(exit_station)
    @exit_station = exit_station
    @current_journey.end(exit_station)
    @journeys << @current_journey.return_journey_hash
    complete_journey_log
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey_method(entry_station)
    @current_journey = @journey_class.new(entry_station)
  end

  def complete_journey_log
    @entry_station = nil
    @exit_station = nil
  end

end
