def sum_of_plants(generations = 20)
  initial_state = Hash.new { |h, k| h[k] = "." }
  patterns = { "#" => [], "." => [] }
  File.readlines('./input.txt').each do |line|
    next if line.strip.empty?
    if line.include?("initial state")
      line.split(":").last.strip.each_char.with_index do |char, idx|
        initial_state[idx] = char
      end
      next
    else
      pattern, result = line.split("=>").map(&:strip)
      patterns[result] << pattern
    end
  end
  generations.times do |time|
    index_to_plant = []
    index_to_not_plant = []
    min_key = initial_state.keys.min
    max_key = initial_state.keys.max
    ((min_key - 2)..(max_key + 2)).each do |idx|
      char = initial_state[idx]
      pot_state = "#{initial_state[idx - 2]}#{initial_state[idx - 1]}#{char}#{initial_state[idx + 1]}#{initial_state[idx + 2]}"
      index_to_plant << idx if patterns["#"].include?(pot_state)
      index_to_not_plant << idx if patterns["."].include?(pot_state)
    end
    index_to_plant.each { |idx| initial_state[idx] = "#" }
    index_to_not_plant.each { |idx| initial_state[idx] = "." }
  end
  initial_state.sort.map(&:last).flatten.join("")
  initial_state.select { |k,v| v == "#" }.keys.inject(&:+)
end

p sum_of_plants
