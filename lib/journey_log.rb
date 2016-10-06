require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journeys  = []
    @journey_class = journey_class
  end

  def start(station)
    set_current_journey_to_nil_if_double_touch_in
    retrieve_current_journey_or_create_new
    @current_journey.entry_station = station
    @journeys << @current_journey
  end

  def finish(station)
    retrieve_current_journey_or_create_new
    insert_current_journey_into_array_if_double_touch_out
    @current_journey.exit_station = station
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

  private

  def set_current_journey_to_nil_if_double_touch_in
    if @journeys.include?(@current_journey)
      @current_journey = nil
    end
  end

  def retrieve_current_journey_or_create_new
    @current_journey ||= @journey_class.new
  end

  def insert_current_journey_into_array_if_double_touch_out
    if !@journeys.include?(@current_journey)
      @journeys << @current_journey
    end
  end

end
