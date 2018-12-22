class Cart
  DIRECTION_TO_MOVES = {
    "up" => [0, -1],
    "down" => [0, 1],
    "left" => [-1, 0],
    "right" => [1, 0]
  }.freeze

  NUM_TURNS_TO_TURN = {
    0 => "left",
    1 => "straight",
    2 => "right"
  }.freeze

  TURNS_TO_DIRECTION = {
    "left" => {
      "up" => "left",
      "down" => "right",
      "left" => "down",
      "right" => "up"
    },
    "right" => {
      "up" => "right",
      "down" => "left",
      "left" => "up",
      "right" => "down"
    },
    "straight" => {
      "up" => "up",
      "down" => "down",
      "left" => "left",
      "right" => "right"
    }
  }.freeze

  attr_accessor :direction
  attr_reader :position, :cart_id

  def initialize(position, direction, cart_id)
    @direction = direction
    @position = position
    @turns = 0
    @cart_id = cart_id
    @crashed = false
  end

  def turn
    @direction = TURNS_TO_DIRECTION[NUM_TURNS_TO_TURN[@turns]][@direction]
    @turns = (@turns + 1) % 3
  end

  def move
    x_mod, y_mod = DIRECTION_TO_MOVES[@direction]
    x, y = @position
    @position = [x + x_mod, y + y_mod]
  end

  def crash
    @crashed = true
  end

  def crashed?
    @crashed
  end
end

def collision
  track = map_track
  track, carts = replace_cart_chars(track)
  first_crash = nil
  until carts.length == 1
    carts = carts.sort_by { |x| [x.position[1], x.position[0]] }
    carts.each.with_index do |cart, idx|
      next if cart.crashed?
      move_cart(track, cart)
      carts.select do |cr_crt|
        carts.any? { |ot_crt| ot_crt.position == cr_crt.position && ot_crt.cart_id != cr_crt.cart_id && !ot_crt.crashed? }
      end.each do |crshed_cart|
        first_crash ||= crshed_cart.position
        crshed_cart.crash
      end
    end
    carts = carts.reject(&:crashed?)
  end
  p "first crash position: #{first_crash}"
  p "last cart: #{carts.first.position}" # giving incorrect answer
end

CURVE_TO_DIRECTION = {
  "\\" => {
    "up" => "left",
    "down" => "right",
    "left" => "up",
    "right" => "down",
  },
  "/" => {
    "up" => "right",
    "down" => "left",
    "left" => "down",
    "right" => "up",
  }
}

def move_cart(track, cart)
  char = track[cart.position[1]][cart.position[0]]
  if char == "\\" || char == "/"
    cart.direction = CURVE_TO_DIRECTION[char][cart.direction]
  elsif char == "+"
    cart.turn
  end
  cart.move
  p "Cart #{cart.cart_id}: #{cart.position}"
end

def map_track
  track_input = File.readlines("./input.txt").map(&:chomp)
  track = Array.new(track_input.length) { Array.new(track_input[0].length) }
  track_input.each_index do |col_idx|
    track_input[col_idx].each_char.with_index do |char, row_idx|
      track[col_idx][row_idx] = char
    end
  end
  track
end

CHAR_TO_TRACK = {
  "^" => "|",
  "v" => "|",
  ">" => "-",
  "<" => "-"
}

CHAR_TO_DIRECTION = {
  "^" => "up",
  "v" => "down",
  ">" => "right",
  "<" => "left"
}

def replace_cart_chars(track)
  carts = []
  cart_id = 1
  track.each_index do |y_idx|
    track[y_idx].each_with_index do |char, x_idx|
      next unless CHAR_TO_TRACK.keys.include?(char)
      track[y_idx][x_idx] = CHAR_TO_TRACK[char]
      carts << Cart.new([x_idx, y_idx], CHAR_TO_DIRECTION[char], cart_id)
      cart_id += 1
    end
  end
  carts = carts.sort_by { |el| [el.position[1], el.position[0]] }
  [track, carts]
end

collision
