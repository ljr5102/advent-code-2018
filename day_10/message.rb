# Solution theoretically would work if run enough times but not practical
class StarPoint
  attr_reader :position, :velocity
  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end

  def x_position
    position[0]
  end

  def y_position
    position[1]
  end

  def x_velocity
    velocity[0]
  end
  
  def y_velocity
    velocity[1]
  end

  def move
    @position = [x_position + x_velocity, y_position + y_velocity]
  end
end

class Sky
  def initialize(stars)
    @stars = stars
  end

  def shift_stars
    @stars.map(&:move)
  end

  def plot
    min_x_point = @stars.min_by(&:x_position).x_position
    min_y_point = @stars.min_by(&:y_position).y_position
    max_x_point = @stars.max_by(&:x_position).x_position
    max_y_point = @stars.max_by(&:y_position).y_position
    x_offset = max_x_point - min_x_point + 1
    y_offset = max_y_point - min_y_point + 1
    grid = Array.new(y_offset) { Array.new(x_offset) }
    @stars.each do |star|
      grid[star.y_position - min_y_point][star.x_position - min_x_point] = star
    end
    drawn = grid.map do |col|
      col.map do |row|
        if row.nil?
          "."
        else
          "X"
        end
      end.join("")
    end
    drawn.each do |col|
      puts col
    end
  end
end

def message
  all_coords = File.readlines('./input.txt').map do |line|
    pos, vel = line.scan(/(?<=\<)(.*?)(?=\>)/).flatten(1).map do |coords|
      coords.split(",").map(&:to_i)
    end
    StarPoint.new(pos, vel)
  end
  sky = Sky.new(all_coords)
  sky.plot
end

message
