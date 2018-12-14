def minutes_asleep
  guard_to_minutes_asleep = grouped_guard_sleep_data
  sleepy_guard = get_sleepy_guard(guard_to_minutes_asleep)
  sleepy_minute = get_sleepy_minute(guard_to_minutes_asleep, sleepy_guard)
  { sleepy_guard: sleepy_guard, sleepy_minute: sleepy_minute }
end

def grouped_guard_sleep_data
  sorted_guard_data = parse_and_sort_guard_data
  group_minutes_asleep_by_guards(sorted_guard_data)
end

def parse_and_sort_guard_data
  parsed = File.readlines('./input.txt').map do |data|
    timestamp_string = parse_time_from_data(data)
    parsed_time = parse_time_args(timestamp_string)
    time = Time.new(*parsed_time)
    action = parse_action_from_data(data)
    [time, action]
  end
  parsed.sort_by { |time, _action| time }
end

def group_minutes_asleep_by_guards(guard_data)
  guard_to_minutes_asleep = Hash.new { |h, k| h[k] = Hash.new(0) }
  current_guard = nil
  current_action = nil
  sleep_start_min = nil
  sleep_finish_min = nil
  guard_data.each do |time, action|
    current_action = get_action_type(action)
    if current_action == :shift_start
      current_guard = get_guard(action)
    end

    if current_action == :sleep
      sleep_start_min = time.min
    end

    if current_action == :wakes
      sleep_finish_min = time.min
      sleep_start_min.upto(sleep_finish_min - 1) do |min|
        guard_to_minutes_asleep[current_guard][min] += 1
      end
    end
  end
  guard_to_minutes_asleep
end

def get_sleepy_guard(guard_data)
  guard_data.keys.max_by do |guard|
    guard_data[guard].values.inject(&:+)
  end
end

def get_sleepy_minute(guard_data, sleepy_guard)
  guard_data[sleepy_guard].keys.max_by do |minute|
    guard_data[sleepy_guard][minute]
  end
end

def parse_time_from_data(data)
  str = ""
  data.each_char do |char|
    str << char unless ["[", "]"].include?(char)
    break if char == "]"
  end
  str
end

def parse_time_args(string)
  date_str, time_str = string.split(" ")
  year, month, day = date_str.split("-").map(&:to_i)
  hour, min = time_str.split(":").map(&:to_i)
  [year, month, day, hour, min]
end

def parse_action_from_data(data)
  data.split("]")[1].strip
end

def get_action_type(action)
  return :shift_start if action.include?("begins shift")
  return :sleep if action.include?("falls asleep")
  return :wakes if action.include?("wakes up")
end

def get_guard(action)
  action.split(" ")[1].gsub("#","").to_i
end

if __FILE__==$0
  p "finding guard with max minutes asleep"
  guard_mins = minutes_asleep
  p "Guard ##{guard_mins[:sleepy_guard]} slept the most minutes and was sleepiest at minute #{guard_mins[:sleepy_minute]} for a product of #{guard_mins[:sleepy_guard] * guard_mins[:sleepy_minute]}"
  p "done"
end
