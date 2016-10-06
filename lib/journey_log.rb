require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journeys  = []
    @journey_class = journey_class
  end

  def start(station)
    current_journey_method(station)
    @journeys << @current_journey
  end

  def finish(station)
    puts "In finish, @current_journey = #{@current_journey}"
    @current_journey.exit_station = station
    #@current_journey = nil
    puts "And then @current_journey = #{@current_journey}"
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey_method(station)
    @current_journey ||= @journey_class.new(station, nil)
  end

end
