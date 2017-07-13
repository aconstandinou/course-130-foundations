# Current implementation

array = [1, 2, 3, 4, 5]

array.select { |num| num.odd? }       # => [1, 3, 5]
array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true


# block version

def select(array)
  counter = 0
  new_array = []
  while counter < array.size
    value = yield(array[counter])
    if value
      new_array << array[counter]
    end
    counter += 1
  end

  new_array
end

array = [1, 2, 3, 4, 5]

select(array) { |num| num.odd? }      # => [1, 3, 5]
select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true

# LS Answer

def select(array)
  counter = 0
  result = []

  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element)
    counter += 1
  end

  result
end
