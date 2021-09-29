class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(starting_balance)
    @balance = starting_balance
    @maximum_limit = MAXIMUM_LIMIT
    # @maximum_limit = TFL_prices::TFL_MINIMUM_FARE
    @minimum_fare = MINIMUM_FARE
    @on_a_journey = false
  end

  attr_reader :balance

  def top_up(amount)
    new_balance = (@balance + amount)

    if  new_balance <= @maximum_limit
      @balance = new_balance
      return  @balance
    else
      p "Maximum limit of #{@maximum_limit} reached"
    end   

  end

  def in_journey?
    @on_a_journey
  end

  def touch_in
    fail "Insufficient card balance" if @balance < @minimum_fare
    @on_a_journey = true
  end

  def touch_out
    @on_a_journey = false
    #touch out, then deduct the fare from @balance
    deduct(@minimum_fare)
  end

  private

  def deduct(fare)
    new_balance = (@balance - fare)
    @balance = new_balance
  end

end
