# easy example of transformation

[1, 2, 3, 4, 5].map do |num|
  num.to_s
end

# => ["1", "2", "3", "4", "5"]

# But there are shortcuts to accomplish this

[1, 2, 3, 4, 5].map(&:to_s)

# Since the return value is an array, we can nest methods

[1, 2, 3, 4, 5].map(&:to_s).map(&:to_i)

# Our shortcut will work with any collection
[1, 2, 3, 4, 5].select(&:odd?)
[1, 2, 3, 4, 5].select(&:odd?).any?(&:even?)

# Essentially, this code
(&:to_s)
#is transformed into
{|n| n.to_s }

# So two things are happening:

# First, Ruby sees if the object after & is a Proc. If it's not, it'll try to
#      call to_proc on the object, which should return a Proc object. If not,
#      this won't work.
# Then, the & will turn the Proc into a block.

# So Ruby is trying to turn :to_s into a block.
# :to_s is a symbol
# Ruby tries to call Symbol#to_proc
# there is one! So the method returns a Proc
# & will turn the returned Proc into a block

# EXAMPLE

def my_method
  yield(2)
end

my_method(&:to_s)

# The code above does the following:

a_proc = :to_s.to_proc
my_method(&a_proc)
