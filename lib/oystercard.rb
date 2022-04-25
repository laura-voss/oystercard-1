class Oystercard

  attr_reader :balance
  
  MAXIMUM_CAPACITY = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_CAPACITY} exceeded" if balance + money > MAXIMUM_CAPACITY
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

end