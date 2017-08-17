require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent_node = nil)
    self.parent.children.delete(self) unless parent.nil?
    @parent = parent_node
    parent_node.children << self unless parent_node.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'not a child' unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |node|
      res = node.dfs(target_value)
      unless res.nil?
        return res if res.value == target_value
      end
    end
  nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      current = queue.shift
      return current if current.value == target_value
      queue.concat(current.children)
    end
  end
end
