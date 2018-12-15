def largest_area(offset)
  coords = File.readlines('./input.txt').map(&:strip).map do |coord|
    coord.split(",").map(&:to_i)
  end
  # coords = [
  #   [1, 1],
  #   [1, 6],
  #   [8, 3],
  #   [3, 4],
  #   [5, 5],
  #   [8, 9],
  # ]

  min_x = coords.min_by { |coord| coord[0] }
  min_y = coords.min_by { |coord| coord[1] }
  max_x = coords.max_by { |coord| coord[0] }
  max_y = coords.max_by { |coord| coord[1] }
  x_length = (max_x[0] - min_x[0]) + offset
  y_length = (max_y[1] - min_y[1]) + offset
  grid = Array.new(y_length) { Array.new(x_length) { Hash.new(0) } }
  coords.each_with_index do |(x, y), idx|
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |column, col_idx|
        dist_x = (col_idx - (x + (offset / 2))).abs
        dist_y = (row_idx - (y + (offset / 2))).abs
        total = dist_x + dist_y
        grid[row_idx][col_idx][idx] = total
      end
    end
  end
  total_coords_less_than_ten_thousand = grid.map do |row|
    row.select do |coors|
      coors.values.inject(&:+) < 10_000
    end
  end.flatten.length
  coords_with_min_dist = grid.map do |row|
    row.map do |coors|
      min = coors.min_by { |k,v| v }
      if coors.select { |k,v| v == min[1] }.length > 1
        nil
      else
        min
      end
    end
  end
  hash = Hash.new(0)
  coords_with_min_dist.flatten(1).each do |indx, dist|
    hash[indx] += 1
  end
 { coord_with_most_mins: hash, total_coords_less_than_ten_thousand: total_coords_less_than_ten_thousand }
end

p "finding largest area"
iter_one = largest_area(500)
iter_two = largest_area(750)
coord_arr =  iter_two[:coord_with_most_mins].select { |k,v| iter_one[:coord_with_most_mins][k] == v && !k.nil? }.max_by { |k,v| v }
p "The coordinate with the most minimums is coordinate index #{coord_arr[0]} with a total of #{coord_arr[1]} minimums. The total region of coordinates with a sum of distances less than 10,000 is #{iter_one[:total_coords_less_than_ten_thousand]}"
p "done"
# iter_two = largest_area(750)
# iter_three = largest_area(1000)
# iter_four = largest_area(1250)
# iter_five = largest_area(1500)
# iter_six = largest_area(1750)
# 291101 incorrect
# 4880 incorrect
