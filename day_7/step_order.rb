require 'byebug'
def step_order
  order = steps_with_prereqs
  completed = []
  until next_step(order, completed).nil?
    completed << next_step(order, completed)
  end
  completed.join("")
end

def steps_with_prereqs
  order = {}
  File.readlines('./input.txt').each do |instruction|
    _step, before, after = instruction.scan(/[A-Z]/)
    order[before] = { prereqs: [], completed: false } unless order[before]
    order[after] = { prereqs: [], completed: false } unless order[after]
    order[after][:prereqs] << before
  end
  order
end

def next_step(order, completed, in_progress = [])
  order.select do |k,v|
    !in_progress.include?(k) && !completed.include?(k) && (v[:prereqs].empty? || v[:prereqs].all? { |y| completed.include?(y) })
  end.keys.min
end

if __FILE__ == $0
  p "getting step order"
  p step_order
  p "done"
end
