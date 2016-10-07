class Journey

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @complete = false
  end

  def end(exit_station)
    @exit_station = exit_station
    @complete = true
    fare
    return_journey_hash
  end

  def complete?
    @complete
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      @fare = Oystercard::PENALTY_FARE
    else
      @fare = Oystercard::MINIMUM_FARE
    end
  end
  
  def return_journey_hash
    {entry_station: @entry_station, exit_station: @exit_station, fare: @fare}
  end
end
