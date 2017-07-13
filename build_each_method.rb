# building an each method

[1, 2, 3].each { |num| "do nothing" }

def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])     # yield to the block, passing in the current element to the block
    counter += 1
  end

  array       # returns the `array` parameter, similar in spirit to how `Array#each` returns the caller
end

each([1, 2, 3, 4, 5]) do |num|
  puts num
end

# Our each method is solely focused on iterating and not on anything beyond that
# Writing a generic iterating method allows method callers to add additional
#    implementation details at method invocation time by passing in a block.
# At each iteration within the while loop, execution then goes to the block
#    (with the current element as the block argument)
