
require_relative 'journey'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey_log = [] #journeylog
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    double_touch_in_checker
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    double_touch_out_checker(exit_station)
    end_current_journey(exit_station)
  end

  def journey_history
    @journey_log
  end

  private

  def deduct(money)
    @balance -= money
  end


  def double_touch_out_checker exit_station
    @current_journey = Journey.new if !@current_journey
  end


  def double_touch_in_checker
    end_current_journey(nil) if @current_journey
  end

  def end_current_journey(exit_station)
    @current_journey.end(exit_station)
    deduct(@current_journey.fare)
    @current_journey = nil
  end
end
