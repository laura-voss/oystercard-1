class Oystercard

  attr_reader :balance
  attr_accessor :status
  
  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @status = "not_in_use"
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_CAPACITY} exceeded" if max_balance?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def touch_in
    fail "Not enough funds" if not_enough?
    fail 'Oyster already touched in' if in_journey?
    @status = "in_use"
  end

  def touch_out
    fail 'Oyster not touched in' if !in_journey?
    @status = "not_in_use"
    @balance -= FARE
  end

  def in_journey?
    @status == "in_use"
  end

  private

  def not_enough?
    @balance < MINIMUM_BALANCE
  end

  def max_balance?(money)
    balance + money > MAXIMUM_CAPACITY
  end

end