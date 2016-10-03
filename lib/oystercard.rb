class Oystercard

  attr_reader :balance, :entry_station, :journey_history

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(val)
    raise "Maxmimum card balance is £#{MAX_BALANCE}" if (@balance + val) > MAX_BALANCE
    @balance += val
  end

  def touch_in(station)
    raise "Insufficient funds: please top up" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct; add_journey(station)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare = MIN_FARE)
    @balance -= fare
  end

  def add_journey(station)
    journey = {start: @entry_station, finish: station}
    @journey_history << journey
  end
end
