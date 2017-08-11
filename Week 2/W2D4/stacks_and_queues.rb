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
    @store.push({el => @max})
    @max = el if el > @max
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
