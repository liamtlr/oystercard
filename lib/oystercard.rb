require_relative 'station'
require_relative 'journey_log'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :list_journeys

  def initialize
    @balance = 0
    @log = JourneyLog.new
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def touch_in(station)
    check_balance
    double_touch_in_check
    @log.start(station)
  end

  def touch_out(station)
    @log.finish(station)
    deduct
  end

  def log
    @log.journeys
  end

  private

  def check_balance
    fail "Card empty - £#{MINIMUM_BALANCE} required" if empty?
  end

  def double_touch_in_check
    deduct unless @log.current_journey.nil? || @log.current_journey.complete?
  end

  def deduct
    @balance -= @log.journeys.last.charge
    "Your new balance is £#{@balance}"
  end

  def empty?
    balance < MINIMUM_BALANCE
  end

  def over_limit? money
    balance + money > TOP_UP_LIMIT
  end

end
