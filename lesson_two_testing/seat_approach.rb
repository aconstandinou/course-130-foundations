# SEAT Approach to testing

# 1. [S]et up the necessary objects.
# 2. [E]xecute the code against the object we're testing.
# 3. [A]ssert the results of the execution.
# 4. [T]ear down and clean up any lingering artifacts.

# in our simple tests so far, we've been doing steps 2 and 3

# Example

require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test

  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def assert_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
  end
end

# The issue here is that each test initializes a new Car object.
# in Minitest, we can do this with setup instance method as follows:

require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def setup
    @car = Car.new        # notice how we use instance variable @car, here and below
  end

  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def assert_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end

# this is known as the setup method, there is also a teardown method.
# teardown method is called after running every test.
