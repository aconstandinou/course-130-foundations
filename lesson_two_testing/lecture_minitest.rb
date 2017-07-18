# many use RSpec, although minitest is the default

# RSpec is what we call a Domain Specific Language; it's a DSL for writing tests.
# Minitest is just written in Ruby

# Test Suite: this is the entire set of tests that accompanies your program or
#             application. You can think of this as all the tests for a project.
# Test: this describes a situation or context in which tests are run. For example,
#            this test is about making sure you get an error message after
#            trying to log in with the wrong password. A test can contain multiple assertions.
# Assertion: this is the actual verification step to confirm that the data
#            returned by your program or application is indeed what is expected.
#            You make one or more assertions within a test.

# FIRST TEST

# First, create a car class within its own code file (.rb)
class Car
  attr_accessor :wheels

  def initialize
    @wheels = 4
  end
end
# Second, in the same directory, create a car_test.rb file
require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end
# Now run: ruby car_test.rb
# Expected output:

# $ ruby car_test.rb
# Run options: --seed 62238
# Running:
# CarTest .
# Finished in 0.001097s, 911.3428 runs/s, 911.3428 assertions/s.
#1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

# Last line tells us our test passed without any errors/failures.

# DIGGING DEEPER INTO THE TEST FILE

line 26: loads all necessary files from minitest gem

line 28: loads the file for our test

line 30: where we create our test class, we need to inherit from MiniTest::Test
        this allows our test class to inherit all the proper methods

- to create tests, we need to define instance methods with #test_
- for each tests, we will need to create some assertions
- these assertions are what were trying to verify
- we then need to instantiate an object from our Class, line 32
- there are a few types of assertions but for now, focus on assert_equal (line 33)
- assert_equal is an inherited instance method, which takes two parameters,
      first is expected value, and the second is the test or actual value.
      if there is an error, minitest will save it and report it at the end
      sometimes, you can have multiple assertions within one test

# FAIL EXAMPLE
saved a file called car_test_fail.rb

#CarTest F.

#Finished in 0.001222s, 1636.7965 runs/s, 1636.7965 assertions/s.

#  1) Failure:
# CarTest#test_bad_wheels [car_test.rb:13]:
# Expected: 3
#  Actual: 4

#2 runs, 2 assertions, 1 failures, 0 errors, 0 skips


# The last line gives us a quick summary, and we can see that there are now 2
# assertions and 1 failure. Minitest further gives us the exact failing test,
# and also tells us the expected value vs the actual value. Also notice at the
# top there's a "F.", which means there were 2 tests, one of which failed
# (that's the "F") and one of which passed (that's the ".").

# DASH OF COLOR
can add color with the following insertion into our code

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    car = Car.new
    assert_equal(3, car.wheels)
  end
end

# failed runs have some red, successful runs are green

# SKIPPING TESTS
# can use the skip keyword to skip a test
# you may want to skip a test because you aren't ready and need to do it later

# result will include some yellow

Finished in 0.00537s
2 tests, 1 assertions, 0 failures, 0 errors, 1 skips

# You could also pass a string into skip if you want a more custom display message.
