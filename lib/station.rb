class Station

  def initialize(lettuce)
    @information = lettuce
  end

  def zone
    @information[:zone]
  end

  def name
    @information[:name]
  end
end