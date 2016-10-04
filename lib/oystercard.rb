class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  attr_reader :balance, :entry_station, :list_journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @list_journeys = []
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Card empty - #{MINIMUM_BALANCE} required" if empty?
    @entry_station = station
  end

  def touch_out(station)
    deduct FARE
    @exit_station = station
    @entry_station = nil
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


end
