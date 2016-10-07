
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(journey_log: JourneyLog)
    @balance = 0
    @journey_log = journey_log.new
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    double_touch_in_checker
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    double_touch_out_checker(exit_station)
    end_current_journey(exit_station)
  end

  private

  def deduct(money)
    @balance -= money
  end


  def double_touch_out_checker exit_station
    @journey_log.start(nil) if !@journey_log.entry_station
  end


  def double_touch_in_checker
    end_current_journey(nil) if @journey_log.entry_station
  end

  def end_current_journey(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.current_journey.fare)
  end
end
