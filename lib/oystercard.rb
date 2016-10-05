
require_relative 'journey'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    if @journeys.empty?
      false
    else
      @journeys.last.exit_station.nil?
    end
  end

  def touch_in(entry_s)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    @journeys << Journey.new(entry_station = entry_s, exit_station = nil)
  end

  def touch_out(exit_s)
    deduct(MINIMUM_FARE)
    if in_journey?
      @journeys.last.exit_station = exit_s
    else
      @journeys << Journey.new(entry_station = nil, exit_station = exit_s)
    end
  end

  def journey_history
    @journeys
  end

  private

  def deduct(money)
    @balance -= money
  end

end
