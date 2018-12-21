def highest_power(grid_serial_number = 0, size = 3, grid = nil)
  square_power = {}
  grid ||= power_grid(grid_serial_number)
  grid.each_index do |y_idx|
    break if grid[y_idx + (size - 1)].nil?
    grid[y_idx].each_index do |x_idx|
      break if grid[x_idx + (size - 1)].nil?
      sum = 0
      grid[y_idx..(y_idx + (size - 1))].each do |col|
        col[x_idx..(x_idx + (size - 1))].each do |row|
          sum += row
        end
      end
      square_power[[x_idx + 1, y_idx + 1, size]] = sum
    end
  end
  square_power
end

def highest_power_with_size_three(grid_serial_number)
  highest_power(grid_serial_number, 3).max_by { |k, v| v }.first
end

def highest_power_with_range(grid_serial_number)
  size_max_to_power = {}
  grid = power_grid(grid_serial_number)
  (1..300).each do |size|
    p size
    power_sum = highest_power(grid_serial_number, size, grid)
    size_max_to_power[size] = power_sum.max_by { |k, v| v }
  end
  p size_max_to_power
  size_max_to_power.values.max_by { |x| x.last }
end

def power_grid(grid_serial_number)
  grid = Array.new(300) { Array.new(300) }
  grid.each_index do |y_idx|
    grid[y_idx].each_index do |x_idx|
      grid[y_idx][x_idx] = power_number(x_idx, y_idx, grid_serial_number)
    end
  end
  grid
end

def power_number(x_idx, y_idx, grid_serial_number)
  x_coord = x_idx + 1
  rack_id = x_coord + 10
  y_coord = y_idx + 1
  hundred_digit(rack_id * (rack_id * y_coord + grid_serial_number)) - 5
end

def hundred_digit(number)
  number / 10 / 10 % 10
end

p highest_power_with_size_three(6878)
p highest_power_with_range(6878)
