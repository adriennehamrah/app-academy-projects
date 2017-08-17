require_relative '00_tree_node.rb'

class KnightPathFinder

  def initialize(start_pos = [0,0])
    @pos = start_pos
    @visited_pos = [start_pos]
    @move_tree = build_move_tree(PolyTreeNode.new(start_pos))
  end

  def find_path(end_pos)
    end_node = nil
    @move_tree.children.each do |node|
      res = node.dfs(end_pos)
      unless res.nil?
        end_node = res if res.value == end_pos
      end
    end

    trace_path_back(end_node)
  end

  private

  def build_move_tree(root_node)
    queue = [root_node]
    until queue.empty?
      current = queue.shift
      new_move_pos(current.value).each do |pos|
        new_node = PolyTreeNode.new(pos)
        queue << new_node
        current.add_child(new_node)
      end
    end
    root_node
  end

  def new_move_pos(pos)
    potential_moves = KnightPathFinder.valid_moves(pos)
    potential_moves = potential_moves - @visited_pos
    @visited_pos.concat(potential_moves)
    potential_moves
  end

  MOVES = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]

  def self.valid_moves(pos)
    x, y = pos
    all_moves = MOVES.map { |move| [move[0] + x, move[1] + y ] }
    all_moves.select {|move| move[0].between?(0,7) &&
                              move[1].between?(0,7)}
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    until end_node.parent.nil?
      end_node = end_node.parent
      path << end_node.value
    end
    path.reverse
  end
end
