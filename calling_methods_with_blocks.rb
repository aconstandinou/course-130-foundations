# example of blocks

[1, 2, 3].each do |num|
  puts num
end

# object = array in this case [1, 2, 3]
# method = Array#each
# block = what is in between do and end

#       do |num|
#   puts num
# end

# block is an argument to the method call. Essentially, our block is
# passed into the Array#each method.


# What can you do with blocks? Common use cases

# Example 1: passing in a block to the `Integer#times` method.

3.times do |num|
  puts num
end
=> 3

# Example 2: passing in a block to the `Array#map` method.

[1, 2, 3].map do |num|
  num + 1
end
=> [2, 3, 4]

# Example 3: passing in a block to the `File::open` class method.

File.open('tmp.txt', 'w') do |file|
  file.write('first line!')
end
=> 11

# Notice how each of these methods have different return values.
# Why is that?
# Well remember that the block is not the method implementation. Since the entire
# block is passed in to the method like any other parameter, its up to the method
# implementation to decide what to do with the block or chunk of code.
