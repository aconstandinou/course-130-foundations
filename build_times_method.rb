
# Re-build a copy of Integer#times method

# here is that implementation:

5.times do |num|
  puts num
end

# 0
# 1
# 2
# 3
# 4
# => 5


# we should be able to start with the following code and get the same result as above

def times(number)
  counter = 0
  while counter < number do
    yield(counter)            # this will follow the block from below
    counter += 1
  end

  number                      # return the original method argument
end

times(5) do |num|
  puts num
end
