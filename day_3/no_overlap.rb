require './overlaps.rb'

def no_overlaps
  fabric_map = overlaps
  File.open('./input.txt').each do |sample|
    parsed = parsed_sample(sample)
    x = parsed[:x]
    y = parsed[:y]
    width = parsed[:width]
    height = parsed[:height]
    id = parsed[:id]
    overlap = false
    y.upto(y + height) do |y_idx|
      x.upto(x + width) do |x_idx|
        overlap = fabric_map[y_idx][x_idx] > 1
        break if overlap
      end
      break if overlap
    end
    next if overlap
    return id
  end.close
end

if __FILE__==$0
  p "finding id with no overlaps"
  p no_overlaps
  p "done"
end
