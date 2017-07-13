# NOTE: Every method you've ever written already takes a block. Ex:

def hello
  "hello!"
end

hello                    # => "hello!"

hello("hi")              # => ArgumentError: wrong number of arguments (1 for 0)

# calling it with a block - works?
hello { puts 'hi' }                      # => "hello!"

# in Ruby, every method can take an optional block as an implicit parameter.

def echo(str)
  str
end

echo                                          # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!")                                # => "hello!"
echo("hello", "world!")                       # => ArgumentError: wrong number of arguments (2 for 1)

# this time, called with an implicit block
echo { puts "world" }                         # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!") { puts "world" }               # => "hello!"
echo("hello", "world!") { puts "world" }      # => ArgumentError: wrong number of arguments (2 for 1)


# NOTE: YIELDING
# How do we invoke the passed-in block? with reserve word yield

def echo_with_yield(str)
  yield
  str
end

echo_with_yield { puts "world" }                        # => ArgumentError: wrong number of arguments (0 for 1)
echo_with_yield("hello!") { puts "world" }              # world
                                                        # => "hello!"
echo_with_yield("hello", "world!") { puts "world" }     # => ArgumentError: wrong number of arguments (2 for 1)

# RULES:
# 1. The number of arguments at method invocation needs to match the method
#    definition, regardless whether we are passing in a block.
# 2. The yield keyword executes the block.

# EDGE CASE
echo_with_yield("hello!")           # => LocalJumpError: no block given (yield)

# How do we get around this?

def echo_with_yield(str)
  yield if block_given?
  str
end

echo_with_yield("hello!")


# NOTE: Passing Execution to Block

# now we can examine sequence of code execution. ex:

# method implementation
def say(words)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
  system 'clear'
end

# clears screen first, then outputs "> hi there"

# method implementation = def say
# method invocation = say... code
# There is only one method here: say.
# Sometimes, when were passing in a block of code, the method invocation can
# contain more code than the method implementation, which makes it easy to confuse
# the two -- dont get mixed up by this.

# 1. Execution starts at method invocation, on line 72.
#    The say method is invoked with two parameters: a string and a block
#    (the block is an implicit parameter and not part of the method definition).
# 2. Execution goes to line 66, where the method local variable words is assigned
#    the string "hi there". The block is passed in implicitly, without being
#    assigned to a variable.
# 3. Execution continues into the first line of the method implementation,
#    line 67, which immediately yields to the block.
# 4. The block parameter, line 73, is now executed, which clears the screen.
# 5. After the block is done executing, execution continues in the method
#    implementation on line 68. Executing line 68 results in output being displayed.
# 6. The method ends, and return value for the method is nil.

# line 72 -> line 66 -> line 67 -> line 73 -> line 68 -> line 69

# NOTE: YIELDING WITH AN ARGUMENT


3.times do |num|
  puts num
end

# 3 is calling object
# times is the method
# do...end is the block
# num in | | is actually the argument to the block!
#     it's a block local variable where scope is constrained to block.
# hint: make sure block argument is unique, and doesn't overshadow local vars outside


# method implementation
def increment(number)
  if block_given?
    yield(number + 1)
  else
    number + 1
  end
end

# method invocation
increment(5) do |num|
  puts num
end

# line 124 → line 116 → line 117 → line 118 → line 124 → line 126 → line 127 → line 122

# NOTE: what if we pass in too many arguments into a block?

# method implementation
def test
  yield(1, 2)                           # passing 2 block arguments at block invocation time
end

# method invocation
test { |num| puts num }                 # expecting 1 parameter in block implementation

# For now, don't worry too much about this, but just realize that blocks
# don't enforce argument count, unlike normal methods in Ruby.

# NOTE: RETURN VALUE OF YIELDING TO THE BLOCK
# Before and After

def compare(str)
  puts "Before: #{str}"
  after = yield(str)                 # return value of yield
  puts "After: #{after}"
end

# method invocation
compare('hello') { |word| word.upcase }

# Before: hello
# After: HELLO
# => nil

# blocks have a return value, and that return value is determined based
# on the last expression in the block

# Note that the last line, => nil, is the return value of the compare method,
# and isn't related to what we're doing in the block.


# NOTE: When to USE BLOCKS IN YOUR OWN METHODS

# 1. Defer some implementation code to method invocation decision.
# METHOD IMPLEMENTOR: sometimes, the implmentor, is not 100% certain of how the method
#                     will be called
# METHOD CALLER: sometimes the method implementor wants to leave it to the method caller

# If you encounter a scenario where you're calling a method from multiple places,
# with one little tweak in each case, it may be a good idea to try implementing
# the method in a generic way by yielding to a block.


# 2 .Methods that need to perform some "before" and "after" actions - sandwich code.

# it's key to note, that the method implementor doesn't care what the Before
# and after is based on... an ex:

def time_it
  time_before = Time.now
  # do something
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end

# The question for the method implementor is: what do we fill in for "do something"?
# The answer is: nothing.
# As the method implementor, we don't care what code goes there.


def time_it
  time_before = Time.now
  yield                       # execute the implicit block
  time_after= Time.now

  puts "It took #{time_after - time_before} seconds."
end

time_it { sleep(3) }                    # It took 3.003767 seconds.
                                        # => nil

# VERY INTERESTING EXAMPLE IVE SEEN IN PYTHON - WHAT IS OPEN METHOD?

File.open("some_file.txt", "w+") do |file|
  # write to this file using file.write
end

# File::open opens the file, yields to the block, then closes the file

# NOTE: METHODS WITH AN EXPLICIT BLOCK PARAMETER

def test(&block)
  puts "What's &block? #{block}"
end

# The &block is a special parameter that will convert the implicitly passed in block into a Proc object.
# Notice that we drop the & when using the parameter in the method implementation

# invoke our method
test { sleep(1) }
# What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# => nil

# Before, we didn't have a handle on the implicit block, so we couldn't do much
# with it except yield to it. Now that we have a variable that represents the block,
# we can pass the block to another method.


# NOTE: SUMMARY

# - blocks are one way that Ruby implements closures. Closures are a way to pass
#   around an unnamed "chunk of code" to be executed later.
# - blocks can take arguments, just like normal methods. But unlike normal methods,
#   it won't complain about wrong number of arguments passed to it.
# - blocks return a value, just like normal methods.
# - blocks are a good use case for "sandwich code" scenarios, like closing a
#   File automatically.
