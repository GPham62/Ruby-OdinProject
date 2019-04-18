class Node
  attr_accessor :value, :parent, :left, :right
  def initialize(value = nil, parent = nil, left = nil, right = nil)
    @value = value
    @parent = parent
    @left = left
    @right = right
  end
end

class BinaryTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def build_tree(array)
    @root = Node.new(array[0])
    array[1..array.size].each{|val| make_node(val)}
  end

  def make_node(val)
    node = @root
    done = false
    until done
      if val >= node.value
        if node.right.nil?
          node.right = Node.new(val, node)
          done = true
        else node = node.right
        end
      else
        if node.left.nil?
          node.left = Node.new(val, node)
          done = true
        else node = node.left
        end
      end
    end
  end

  def breadth_first_search(value)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      return node if node.value == value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
  end

  def depth_first_search(value)
    visited = []
    stack = [@root]
    until stack.empty?
      node = stack[-1]
      return node if node.value == value
      visited << node
      if node.left && !(visited.include? node.left)
        stack << node.left
      elsif node.right && !(visited.include? node.right)
        stack << node.right
      else stack.pop
      end
    end
    nil
  end

  def dfs_rec(value, node = @root)
    return if node.nil?
    puts "Node found: #{node.value} #{node}" if node.value == value
    dfs_rec(value, node.left) unless node.left.nil?
    dfs_rec(value, node.right) unless node.right.nil?
  end
end

binary_tree = BinaryTree.new
array =  [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
binary_tree.build_tree(array)
binary_tree.dfs_rec(69)