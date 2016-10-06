require_relative 'station'
require_relative 'journey'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :list_journeys

  def initialize
    @balance = 0
    @list_journeys = []
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def touch_in(station)
    fail_check
    @journey = Journey.new(station)
    @list_journeys << @journey
  end

  def touch_out(station)
    touch_out_check(station)
    deduct
  end

  def list_journeys
    @list_journeys
  end

private

  def fail_check
    fail "Card empty - £#{MINIMUM_BALANCE} required" if empty?
    if !@journey.nil?
      deduct if !@journey.complete?
    end
  end

  def touch_out_check(station)
    if @journey.nil? || !@journey.exit_station.nil?
      @journey = Journey.new(nil, station)
      @list_journeys << @journey
    else
      @journey.exit_station = station
    end
  end

  def deduct
    @balance -= @journey.charge
    "Your new balance is £#{@balance}"
  end

  def empty?
    balance < MINIMUM_BALANCE
  end

  def over_limit? money
    balance + money > TOP_UP_LIMIT
  end

end
