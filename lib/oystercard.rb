class Oystercard

  attr_reader :balance, :journey, :journey_history
  
  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @journey = {}
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_CAPACITY} exceeded" if max_balance?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail "Not enough funds" if not_enough?
    fail 'Oyster already touched in' if in_journey?
    @journey[:in] = entry_station
  end

  def touch_out(exit_station)
    fail 'Oyster not touched in' if !in_journey?
    deduct
    @journey[:out] = exit_station 
    @journey_history << @journey
    @journey = {}
  end

  def in_journey?
    @journey[:in] != nil && @journey[:out] == nil
  end

  private

  def not_enough?
    @balance < MINIMUM_BALANCE
  end

  def max_balance?(money)
    balance + money > MAXIMUM_CAPACITY
  end

  def deduct
    @balance -= FARE
  end

end