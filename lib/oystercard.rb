class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(val)
    raise "Maxmimum card balance is £#{MAX_BALANCE}" if (@balance + val) > MAX_BALANCE
    @balance += val
  end

  def touch_in
    raise "Insufficient funds: please top up" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    deduct; @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(fare = MIN_FARE)
    @balance -= fare
  end
end
