class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Card empty - #{MINIMUM_BALANCE} required" if empty?
    @in_journey=true
  end

  def touch_out
    deduct FARE
    @in_journey=false
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
