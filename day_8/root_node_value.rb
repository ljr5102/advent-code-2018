require('./sum_metadata.rb')

def root_node_value
  node_value(build_node_tree)
end

def node_value(node)
  if node.children.empty?
    return node.metadata.inject(&:+) if node.children.empty?
  end
  node.metadata.map do |data|
    val = 0
    idx = data - 1
    child = node.children[idx]
    data.zero? || child.nil? ? val : node_value(child)
  end.inject(&:+)
end

p "finding root node value"
p root_node_value
p "done"
