# When writing tests, we want to get an idea of code coverage...

# CODE COVERAGE: our TodoList test has all public methods covered.

# There is a code coverage tool called simplecov (which we gem install)

# Add the following to our todolist_test.rb file
require 'simplecov'
SimpleCov.start

# next time we run that ruby code, it will generate a new directory coverage
#    you can open up the index.html file which will tell you how much % covered
#    we are with our current test.
