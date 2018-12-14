require ("./minutes_asleep")

def most_frequent_minute
  guard_data = grouped_guard_sleep_data
  guard_frequent_minute = find_guard_frequent_minute(guard_data)
  max_minute_for_guards(guard_frequent_minute)
end

def find_guard_frequent_minute(guard_data)
  guard_data.keys.map do |guard|
    minute, amount_slept = guard_data[guard].max_by { |_min, amt| amt }
    { guard: guard, frequent_minute: minute, minutes_asleep: amount_slept }
  end
end

def max_minute_for_guards(guard_minute)
  guard_minute.max_by do |guard_mins|
    guard_mins[:minutes_asleep]
  end
end

if __FILE__==$0
  p "finding most frequent minute"
  min = most_frequent_minute
  p "Guard ##{min[:guard]} had the most frequent minute sleeping #{min[:minutes_asleep]} minutes during minute #{min[:frequent_minute]} for a product of #{min[:guard] * min[:frequent_minute]}"
  p "done"
end
