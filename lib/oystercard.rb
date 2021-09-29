class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(starting_balance)
    @balance = starting_balance
    @maximum_limit = MAXIMUM_LIMIT
    @minimum_fare = MINIMUM_FARE
    @entry_station = nil
  end

  attr_reader :balance, :entry_station

  def top_up(amount)
    if under_maximum_limit?(amount)
      @balance += amount
    else
      "Maximum limit of #{@maximum_limit} reached"
    end   
  end

  def touch_in(entry_station)
    fail "Insufficient card balance" if @balance < @minimum_fare
    @entry_station = entry_station
  end

  def touch_out
    #touch out, then deduct the fare from @balance
    deduct(@minimum_fare)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(fare)
    new_balance = (@balance - fare)
    @balance = new_balance
  end

  def under_maximum_limit?(amount)
    @balance + amount <= @maximum_limit
  end

end
