require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :in_journey, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @journey_history = []
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Insufficient funds for jouney' if @balance < MINIMUM_FARE
    @entry_station = station

  end

  def touch_out(exit_station)
    deduct
    journey_hash = { :station => self.entry_station, :exit_station =>  exit_station }
    journey_history << journey_hash
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

private

  def deduct(amount = MINIMUM_FARE)
    @balance -= amount
  end

end
