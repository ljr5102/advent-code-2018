def frequency_calculator
  File.readlines('./input.txt').map(&:to_i).inject(&:+)
end

p "calculating frequency"
p frequency_calculator
p "done"
