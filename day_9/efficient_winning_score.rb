class LinkedNode
  attr_reader :value
  attr_accessor :next, :prev
  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

def efficient_winning_score
  num_players, num_turns = File.open('./input.txt').read.scan(/\d+/).map(&:to_i)
  # num_turns *= 100 comment in for part 2 solution
  score = Hash.new(0)
  current = LinkedNode.new(0)
  current_player = 0
  1.upto(num_turns) do |marble_value|
    if (current.prev && current.next).nil?
      new_node = LinkedNode.new(marble_value)
      current.next = new_node
      new_node.prev = current
      new_node.next = current
      current = new_node
      current_player = (current_player + 1) % num_players
      next
    end
    if marble_value % 23 == 0
      score[current_player] += marble_value
      node_to_remove = current
      7.times { |_time| node_to_remove = node_to_remove.prev }
      score[current_player] += node_to_remove.value
      node_to_remove.prev.next = node_to_remove.next
      node_to_remove.next.prev = node_to_remove.prev
      current = node_to_remove.next
    else
      outer = current.next.next
      inner = current.next
      new_node = LinkedNode.new(marble_value)
      new_node.next = outer
      outer.prev = new_node
      new_node.prev = inner
      inner.next = new_node
      current = new_node
    end
    current_player = (current_player + 1) % num_players
  end
  score.max_by { |_k, v| v }[1]
end

p "finding winning score efficiently"
p efficient_winning_score
p "done"
