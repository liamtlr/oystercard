class Journey

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      @fare = Oystercard::PENALTY_FARE
    else
      @fare = Oystercard::MINIMUM_FARE
    end
  end

  def return_journey_hash
    {entry_station: @entry_station, exit_station: @exit_station, fare: fare}
  end
end
