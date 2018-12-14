require('./polymer_react.rb')

def best_polymer(original_polymer = File.open("./input.txt").map(&:strip).first)
  updated_polymers = ("a".."z").map { |unit| original_polymer.gsub(unit, '').gsub(unit.upcase, '') }
  updated_polymers.map.with_index do |polymer, idx|
    Thread.new do
      polymer_react(polymer)
    end
  end.map(&:value).min_by do |pol|
    pol.length
  end
end

p "finding best polymer combo"
best = best_polymer
p "the best reacted polymer is #{best}"
p "the resulting length is #{best.length}"
p "done"
