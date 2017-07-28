# assert_equal is one of the most useful assertions, but how is it testing for equality?
# Are we talking object equality? Or value equality? Or both?

# When we use assert_equal, we are testing for value equality.
# If we're looking for more strict object equality, then we need to use the assert_same assertion.

# quick Example

require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = "hi there"
    str2 = "hi there"

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end

# our first test assert_equal will pass
# our second test assert_same will fail.... why?
# =>  this is because they both point to diff object IDs

# NOTE: EQUALITY WITH A CUSTOM CLASS

# REMEMBER: to test for value equality, we can get away with using assert_equal
# on strings, arrays, hashes, etc. but not on Class objects

# The answer is we have to tell Minitest how to compare those objects by
# implementing our own == method. Let's use our familiar Car class, except
# we'll add a == method.

# But before we do that, let's take a look at what would happen if we did not
# have a == method, and we tried to call assert_equal.

class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)
  end
end

# Running:

# CarTest F
#
# Finished in 0.021080s, 47.4375 runs/s, 47.4375 assertions/s.
#
#   1) Failure:
# CarTest#test_value_equality [car_test.rb:48]:
# No visible difference in the Car#inspect output.
# You should look at the implementation of #== on Car or its members.
# #<Car:0xXXXXXX @wheels=4, @name="Kim">
#
# 1 runs, 1 assertions, 1 failures, 0 errors, 0 skips

class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end

  def ==(other)                   # assert_equal would fail without this method
    other.is_a?(Car) && name == other.name
  end
end

# We can now call assert_equal on Car objects.

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)          # this will pass
    assert_same(car1, car2)           # this will fail
  end
end


# Now that we told Ruby how to compare two Car objects, we can use assert_equal.
# Notice that assert_same is unaffected, because it's still looking at whether
# the two arguments are the same actual object.
