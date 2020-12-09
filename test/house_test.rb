require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_readable_attributes
    house = House.new("$400000", "123 sugar lane")
    assert_equal 400000, house.price
    assert_equal "123 sugar lane", house.address
    assert_equal [], house.rooms
  end

  def test_it_has_rooms
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    house.add_room(room_1)
    house.add_room(room_2)

    assert_equal [room_1, room_2], house.rooms
  end

  def test_is_it_above_market_average
    house = House.new("$400000", "123 sugar lane")

    refute house.above_market_average?
  end

  def test_it_can_return_rooms_by_category
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal [room_4], house.rooms_from_category(:basement)
    assert_equal 1900, house.area
  end

  def test_it_can_return_price_per_square_foot
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal 210.53, house.price_per_square_foot
  end
end

# house.rooms_sorted_by_area #=> [#<Room:0x00007fccd297dc30...>, #<Room:0x00007fccd383c2d0...>, #<Room:0x00007fccd2985f48...>, #<Room:0x00007fccd29b5720...>]
#
# house.rooms_by_category #=> {:bedroom=>[#<Room:0x00007fccd29b5720...>, #<Room:0x00007fccd2985f48...>], :living_room=> [#<Room:0x00007fccd383c2d0...>], :basement=> [#<Room:0x00007fccd297dc30...>]}
