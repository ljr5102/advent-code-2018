def overlaps
  total_fabric = Array.new(1000) { Array.new(1000, 0) }
  File.open('./input.txt').each do |sample|
    parsed = parsed_sample(sample)
    x = parsed[:x]
    y = parsed[:y]
    width = parsed[:width]
    height = parsed[:height]
    y.upto(y + (height - 1)) do |y_idx|
      x.upto(x + (width - 1)) do |x_idx|
        total_fabric[y_idx][x_idx] += 1
      end
    end
  end.close
  total_fabric
end

def parsed_sample(sample)
  split_sample = sample.strip.split("@")
  id = split_sample[0].strip.gsub("#",'').to_i
  parsed = split_sample[1].strip.split(":").map(&:strip)
  x, y = parsed[0].split(",").map(&:to_i)
  width, height = parsed[1].split("x").map(&:to_i)
  { id: id, x: x, y: y, width: width, height: height }
end

def area_overlap
  overlaps.flatten.select { |fabric| fabric >= 2 }.length
end

if __FILE__==$0
  p "finding overlaps"
  p area_overlap
  p "end"
end
