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

  def find_by_title(object_string_to_find)
    select { |todo| todo.title == object_string_to_find}.first   # since it returns a list object.
  end

  def all_done
    select { |todo| todo.done? == true}
  end

  def all_not_done
    select { |todo| todo.done? == false}
  end

  def mark_done(object_to_mark_done)
    select { |todo| todo.title == object_to_mark_done}.first.done!
  end

  def mark_all_done
    each { |todo| todo.done!}
  end

  def mark_all_undone
    each { |todo| todo.undone!}
  end
  
  def select
    list = TodoList.new(title)

    each do |todo|
      list.add(todo) if yield(todo)
    end
    list
  end

  def each
    counter = 0

    while counter < @todos.size
      return self if yield(@todos[counter])
      counter += 1
    end
    self                             # modified to return instance
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

todo1.done!
p list.find_by_title('Buy milk')
p list.all_done
