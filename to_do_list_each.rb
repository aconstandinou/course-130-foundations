class TypeError
end

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def each
    counter = 0

    while counter < @todos.size
      yield(@todos[counter])
      counter += 1
    end
  end

  def add(object_to_add)
    if object_to_add.class == Todo
      @todos << object_to_add
    else
      raise TypeError, 'Can only add Todo objects'
    end
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(element)
    @todos[element]
  end

  def mark_done_at(element)
    @todos[element].done!
  end

  def mark_undone_at(element)
    @todos[element].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(ele)
    to_return = @todos[ele]
    @todos.delete(ele)
    to_return
  end

  def to_s
    @todos.each do |object_todo|
      puts object_todo
    end
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end
