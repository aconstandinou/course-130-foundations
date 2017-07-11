# closure: programming concept to save a "chunk" of code, and execute
# =>      at a later time.
# bind surrounding artifacts (variables, methods, objects, etc.) and build
# an enclosure around it, so that they are referenced later when the closure is executed.

# in Ruby, closures are implemented as PROC object
# why not just store it in a method? its actually quite handy, and they can
# be passed into methods!

# remember: PROC object retains references to its surrounding artificats - ITS BINDING

# 3 main ways to work with closures in Ruby:
# 1. Instantiating an object from PROC class
# 2. Using lambdas
# 3. using blocks
