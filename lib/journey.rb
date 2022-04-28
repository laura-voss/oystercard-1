class Journey

  attr_reader :complete_journey, :penalty

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @current_journey = {}
    @complete_journey = {}
    @penalty = false
  end
  
  def begin(entry_station)
    in_journey? ? @penalty = true : @penalty = false
    @current_journey[:in] = entry_station  
  end
  
  def end(exit_station)
    @penalty = true if !in_journey?
    @current_journey[:out] = exit_station
    @complete_journey = @current_journey
    @current_journey = {}
  end

  def calculate_fare
    @penalty ? 6 : 1
  end
  
  def in_journey?
    !!@current_journey[:in]
  end

end