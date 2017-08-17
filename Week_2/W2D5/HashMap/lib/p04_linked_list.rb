class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @nodes = Array.new(2) {Node.new}
  end

  def [](i)
    @nodes.each_with_index { |link, j| return link if i + 1 == j }
    nil
  end

  def first
    @nodes[1]
  end

  def last
    @nodes[-2]
  end

  def empty?
    @nodes.size < 3
  end

  def get(key)
    @nodes.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    selected_node_arr = @nodes.select {|node| node.key == key}
    return true if selected_node_arr
    false 
  end

  def append(key, val)
    node = Node.new(key, val)
    node.next = @nodes[-1]
    node.prev = @nodes[-2]

    @nodes.insert(-2, node)
  end

  def update(key, val)
    selected_node_arr = @nodes.select {|node| node.key == key}

    if selected_node_arr.empty?
      return false
    else
      selected_node_arr[0].val = val
    end
  end

  def remove(key)
    selected_node = @nodes.select {|node| node.key == key}[0]
    if selected_node.nil?
      return false
    else
      idx = @nodes.index(selected_node)
      @nodes[idx + 1].prev = @nodes[idx - 1]
      @nodes[idx - 1].next = @nodes[idx + 1]
      @nodes.delete(selected_node)
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
