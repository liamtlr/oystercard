require_relative 'station'
require_relative 'journey'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :list_journeys, :current_journey

  def initialize(balance = 0)
    @balance = balance
    @list_journeys = []
    @current_journey = nil
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def touch_in(station)
    fail "Card empty - #{MINIMUM_BALANCE} required" if empty?
    if @current_journey
       @current_journey.end_journey()
       record_journey
       @current_journey = Journey.new(station)
    else @current_journey = Journey.new(station)
    end
  end

  def touch_out(station)
    @current_journey = current_journey || Journey.new("Unknown")
    @current_journey.end_journey(station)
    deduct @current_journey.fare
    record_journey
    @current_journey = nil
  end

private

  def deduct money
    @balance -= money
  end

  def empty?
    balance < MINIMUM_BALANCE
  end

  def over_limit? money
    balance + money > TOP_UP_LIMIT
  end

  def record_journey
    @list_journeys << @current_journey.stations
  end

end
