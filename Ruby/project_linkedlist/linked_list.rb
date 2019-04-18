require './node.rb'
class LinkedList
  attr_accessor :head, :current_node
  def initialize
    @head = Node.new("HEAD", nil)
    @current_node = @head
  end

  def append(new_data)
    if @current_node.pointer == nil
      new_node = Node.new(new_data, nil)
      @current_node.pointer = new_node
    elsif @current_node.pointer != nil
      @current_node = @current_node.pointer
      append(new_data)
    end
  end

  def prepend(new_data)
    new_head = Node.new(new_data, @current_node.pointer)
    new_head.pointer = @head
    @head = new_head
  end

  def size
    @current_node = @head
    size = 1
    until @current_node.pointer == nil
      size += 1
      @current_node = @current_node.pointer
    end
    size
  end

  def head
    @current_node = @head
  end

  def tail
    until @current_node.pointer == nil
      @current_node = @current_node.pointer
    end
    @current_node
  end

  def at(idx)
    return "index is bigger than current size" if idx > self.size
    @current_node = @head
    current_idx = 0
    until idx == current_idx
      @current_node = @current_node.pointer
    end
    @current_node
  end

  def pop
    @current_node = @head
    until @current_node.pointer == nil
      node_before = @current_node
      @current_node = @current_node.pointer
    end
    node_before.pointer = nil
    @current_node
  end

  def contains?(val)
    @current_node = @head
    until @current_node.pointer == nil
      if @current_node.data == val
        return true
      else @current_node = @current_node.pointer
      end
    end
    false
  end

  def find(data)
    @current_node = @head
    until @current_node.pointer == nil
      if @current_node.data == data
        return data
      else @current_node = @current_node.pointer
      end
    end
    nil
  end

  def to_s
    @current_node = @head
    until @current_node.pointer == nil
      print "#{current_node.data} -> "
      @current_node = @current_node.pointer
    end
    print "#{@current_node.data} -> nil"
  end

  def insert_at(data, idx)
    return "index is bigger than current size" if idx > self.size
    at(idx)
    new_node = Node.new(data, @current_node.pointer)
    @current_node.pointer = new_node
  end

  def remove_at(idx)
    at(idx)
    val = @current_node
    at(idx-1)
    @current_node.pointer = val.pointer
  end
end


linked_list = LinkedList.new

linked_list.prepend("New head")

puts linked_list.to_s
puts linked_list.pop
puts linked_list.to_s