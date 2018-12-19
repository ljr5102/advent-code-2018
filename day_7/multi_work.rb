require('./step_order.rb')

def time_to_complete
  order = steps_with_prereqs
  completed = []
  in_progress = []
  status = {}
  5.downto(1) do |worker|
    step = next_step(order, completed, in_progress)
    in_progress << step unless step.nil?
    status["Worker #{worker}"] = { step: step, time_remaining: time_for_step(step) }
  end
  start = 0
  until work_complete?(status)
    start += 1
    status.keys.each do |worker|
      if status[worker][:step]
        time_rem = status[worker][:time_remaining] - 1
        if time_rem.zero?
          in_progress.delete(status[worker][:step])
          completed << status[worker][:step]
          status[worker] = {step: nil, time_remaining: nil }
        else
          status[worker][:time_remaining] = time_rem
        end
      end
    end
    status.keys.each do |worker|
      next unless status[worker][:step].nil?
      step = next_step(order, completed, in_progress)
      in_progress << step unless step.nil?
      status[worker] = { step: step, time_remaining: time_for_step(step) }
    end
  end
  start
end

def time_for_step(step)
  return nil if step.nil?
  ("A".."Z").to_a.index(step) + 1 + 60
end

def work_complete?(status)
  status.all? { |_k, v| v[:step].nil? }
end

p "finding hours to complete work"
p time_to_complete
p "done"
