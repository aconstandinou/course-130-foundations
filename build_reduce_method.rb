# First lets get re-aquainted with the reduce (inject) method

[1, 2, 3].reduce do |acc, num|
  puts acc
  acc + num
end

# in this case, puts acc will start with 1 then 3 then nothing.

# caller: [1,2,3]
# method call: reduce
# block: do..end

# reduce method yields two arguments to the block, an accumulator and current element

# You can also initialize accumulator to a default value

[1, 2, 3].reduce(10) do |acc, num|
  acc + num
end

# => 16

# this initializes the accumulator object from 10.

# NOTE: our reduce method also returns (upon each iteration) the acc.
# hence why you can't get away with this

[1, 2, 3].reduce do |acc, num|
  acc + num if num.odd?
end

# when we get to 2 in our array, it would return nil (line 30 conditional statement)
# then on the next iteration, it would have an error since we cant add nil to 3.

def reduce(array, accum = 0)
  counter = 0
  accumulator = accum

  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end

  accumulator
end

array = [1, 2, 3, 4, 5]

reduce(array) { |acc, num| acc + num }                    # => 15
reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClas
