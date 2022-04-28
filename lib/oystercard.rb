class Oystercard

  attr_reader :balance, :journey, :journey_history
  
  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_CAPACITY} exceeded" if max_balance?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail "Not enough funds" if not_enough?
    @journey.begin(entry_station)
    deduct(@journey.calculate_fare) if @journey.penalty == true
  end

  def touch_out(exit_station)
    @journey.end(exit_station)
    @journey_history << @journey.complete_journey  
    deduct(@journey.calculate_fare)
  end

  private

  def not_enough?
    @balance < MINIMUM_BALANCE
  end

  def max_balance?(money)
    balance + money > MAXIMUM_CAPACITY
  end

  def deduct(fare)
    @balance -= fare
  end

end