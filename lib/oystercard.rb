class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  attr_reader :balance, :list_journeys, :current_journey

  def initialize
    @balance = 0
    @list_journeys = []
    @current_journey={}
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def in_journey?
    !@current_journey.empty?
  end

  def touch_in(station)
    fail "Card empty - #{MINIMUM_BALANCE} required" if empty?
    set_entry(station)
  end

  def touch_out(station)
    deduct FARE
    set_exit(station)
    record_journey
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
    @list_journeys << @current_journey
    @current_journey = {}
  end

  def set_entry(station)
    @current_journey[:entry_station] = station
  end

  def set_exit(station)
    @current_journey[:exit_station] = station
  end

end
