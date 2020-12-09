class House
  attr_reader :price, :address, :rooms
  def initialize(price, address)
    @price = price.gsub('$', '').to_i
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    false
  end

  def rooms_from_category(category)
    @rooms.select do |room|
      room.category == category
    end
  end

  def area
    @rooms.sum do |room|
      room.area
    end
  end

  def price_per_square_foot
    #I need a variable generated in above method that I can use here for calculation.
  end
end
