class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first.dup
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
    @max = 0
  end

  def pop
    @max = @store.last.values[0]
    @store.pop
  end

  def push(el)
    @store.push(el)
  end

  def peek
    @store.last.dup
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class StackQueue
  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    return @out_stack.pop unless @out_stack.empty?
    until @in_stack.empty?
      @out_stack.push(@in_stack.pop)
    end
    @out_stack.pop
  end

  def size
    @in_stack.length + @out_stack.length
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
end

class MaxMinStack
  def initialize
    @store = MyStack.new
  end

  def push(el)
    @store.push(
      max: new_max(el),
      min: new_min(el),
      value: el
    )
  end

  def pop
    @store.pop[:value] unless empty?
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  def peek
    max = @max
    @store.peek[:value] unless empty?
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end

  private

  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end

class MaxMinStackQueue
  def initialize
    @in_stack = MaxMinStack.new
    @out_stack = MaxMinStack.new
  end

  def enqueue(el)
    @in_stack.push(el)
  end

  def dequeue
    return @out_stack.pop unless @out_stack.empty?
    until @in_stack.empty?
      @out_stack.push(@in_stack.pop)
    end
    @out_stack.pop
  end

  def max
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end

  def size
    @in_stack.length + @out_stack.length
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
end
