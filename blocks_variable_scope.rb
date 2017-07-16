# Refresher

# LOCAL VARIABLES ONLY: A block creates a new scope for local variables, and
#                       only outer local variables are accessible to inner blocks.

level_1 = "outer-most variable"

[1, 2, 3].each do |n|                     # block creates a new scope
  level_2 = "inner variable"

  ['a', 'b', 'c'].each do |n2|            # nested block creates a nested scope
    level_3 = "inner-most variable"

    # all three level_X variables are accessible here
  end

  # level_1 is accessible here
  # level_2 is accessible here
  # level_3 is not accessible here

end

# level_1 is accessible here
# level_2 is not accessible here
# level_3 is not accessible here

# Closure and binding
# block:  is how Ruby implements the idea of a closure, which is a general
#          computing concept of a "chunk of code" that you can pass around
#          and execute at some later time

# blocks are a kind of Proc

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

# If you try to run that code, nothing will happen. That's because we've
# created a Proc and saved it to chunk_of_code, but haven't executed it yet.

# EXAMPLE

def call_me(some_code)
  some_code.call            # call will execute the "chunk of code" that gets passed in
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)

# output
# hi Robert
# => nil

# How?

# we know that local variable 'name' (line 46) isn't available to our method call_me
# since it was initialized outside and wasn't passed in as an argument..

# That leads us to think that chunk_of_code (line 47) maybe pre-processed?

# Let's test it out!

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"        # re-assign name after Proc initialization

call_me(chunk_of_code)

# output

# hi Griffin III
# => nil

# So even re-assigning the variable after the Proc is initialized updates the
# chunk_of_code. This implies that the Proc keeps track of its surrounding context,
# and drags it around wherever the chunk of code is passed to. In Ruby,
# we call this its binding, or surrounding environment/context.
# A closure must keep track of its surrounding context in order to have all the
# information it needs in order to be executed later.

# THIS SEEMS TO VIOLATE ORIGINAL VARIABLE SCOPING RULES. GOOD TO REMEMBER!
