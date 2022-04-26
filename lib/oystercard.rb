class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey, :journey_history
  attr_accessor :status
  
  MAXIMUM_CAPACITY = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    # @status = "not_in_use"
    # @entry_station = nil
    # @exit_station = nil
    @journey = {in: nil, out: nil}
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance of #{MAXIMUM_CAPACITY} exceeded" if max_balance?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail "Not enough funds" if not_enough?
    fail 'Oyster already touched in' if in_journey?
    # @status = "in_use"
    # @entry_station = entry_station
    @journey[:in] = entry_station
    # add_to_journey(entry_station)
  end

  def touch_out(exit_station)
    fail 'Oyster not touched in' if !in_journey?
    # @status = "not_in_use"
    deduct
    # @entry_station = nil
    # @exit_station = exit_station
    @journey[:out] = exit_station 
    # add_to_journey(exit_station)
    @journey_history << @journey
  end

  def in_journey?
    # @entry_station
    @journey[:out]
  end

  private

  # def add_to_journey(station)
  #   journey = []
  #   journey << station

  #   @journey = {in: journey[0], out: journey[1]}
  # end

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