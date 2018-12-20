class MetadataNode
  attr_accessor :num_children, :num_metadata, :parent
  attr_reader :children, :metadata

  def initialize
    @children = []
    @metadata = []
  end

  def add_child(child)
    child.parent = self
    @children << child
  end

  def add_metadata(num)
    @metadata << num
  end

  def complete_children?
    num_children && @children.length == num_children
  end

  def complete_metadata?
    num_metadata && @metadata.length == num_metadata
  end
end

def sum_metadata
  all_metadata = []
  child_queue = [build_node_tree]
  until child_queue.empty?
    current = child_queue.shift
    all_metadata.concat(current.metadata)
    child_queue.concat(current.children)
  end
  all_metadata.inject(&:+)
end

def build_node_tree
  current_node = nil
  node_list.each do |el|
    if current_node.nil?
      current_node = MetadataNode.new
      current_node.num_children = el
      next
    end

    if current_node.num_metadata.nil?
      current_node.num_metadata = el
      next
    else
      if current_node.complete_children?
        if current_node.complete_metadata?
          current_node = current_node.parent
          if current_node.complete_children?
            current_node.add_metadata(el)
            next
          end
          child_node = MetadataNode.new
          child_node.num_children = el
          current_node.add_child(child_node)
          current_node = child_node
        else
          current_node.add_metadata(el)
          next
        end
      else
        child_node = MetadataNode.new
        child_node.num_children = el
        current_node.add_child(child_node)
        current_node = child_node
      end
    end
  end
  current_node
end

def node_list
  list = []
  File.open('./input.txt').each do |line|
    list = line.split(/\s+/).map(&:to_i)
  end
  list
end

if __FILE__ == $0
  p "finding sum of metadata"
  p sum_metadata
  p "done"
end
