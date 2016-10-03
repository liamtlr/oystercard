class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(val)
    raise "Maxmimum card balance is £#{MAX_BALANCE}" if (@balance + val) > MAX_BALANCE
    @balance += val
  end

  def deduct(fare)
    @balance -= fare
  end

end
