require_relative 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station, :current_journey

  def initialize(journey_class: Journey )
    @journey_class = journey_class
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    double_touch_in_checker
    @entry_station = entry_station
  end

  def finish(exit_station)
    double_touch_out_checker
    @exit_station = exit_station
    current_journey_method(entry_station, exit_station)
    @journeys << @current_journey.return_journey_hash
    clear_journey_log
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey_method(entry_station, exit_station)
    @current_journey = @journey_class.new(entry_station, exit_station)
  end

  def clear_journey_log
    @entry_station = nil
    @exit_station = nil
  end

  def double_touch_out_checker
    self.start(nil) if !entry_station
  end

  def double_touch_in_checker
    self.finish(nil) if entry_station
  end

end
