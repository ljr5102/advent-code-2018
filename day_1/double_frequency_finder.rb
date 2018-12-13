require 'byebug'
def double_frequency_finder
  frequencies_found = Hash.new(0)
  frequencies_found[0] += 1
  current_frequency = 0
  until frequencies_found.values.include?(2)
    File.readlines('./input.txt').map(&:to_i).each do |val|
      current_frequency += val
      frequencies_found[current_frequency] += 1
      break if frequencies_found.values.include?(2)
    end
  end
  frequencies_found.find { |_freq, times_found| times_found == 2 }.first
end

p "finding first frequency hit twice"
p double_frequency_finder
p "done"
