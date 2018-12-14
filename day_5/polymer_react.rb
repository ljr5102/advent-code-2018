def polymer_react(polymer = File.open('./input.txt').map(&:strip).first)
  reg = build_regex
  reacted = react(polymer, reg)
  until polymer == reacted
    polymer = reacted
    reacted = react(polymer, reg)
  end
  polymer
end

def build_regex
  combos = ("a".."z").zip("A".."Z").map(&:join)
  combos.concat(combos.map(&:reverse)).freeze
  regex = combos.map { |x| "(#{x})" }.join("|").freeze
  /#{regex}/
end

def react(polymer, reg)
  polymer.sub(reg, '') # TODO: find more efficient solution. The best_polymer method with threads takes 1849 seconds to run. Has to be more efficient solution.
end

def react_old(polymer)
  # made this solution first. Switched to regex thinking it may be more efficient. Results unclear
  reacted = ""
  0.upto(polymer.length - 1) do |idx|
    char = polymer[idx]
    next_char = polymer[idx + 1]
    if next_char && char != next_char && (char.upcase == next_char || char.downcase == next_char)
      reacted << polymer.slice(idx + 2, polymer.length - 1)
      break
    end
    reacted << char
  end
  reacted
end

if __FILE__ == $0
  p "finding reacted polymer"
  polymer = polymer_react
  p "resulting polymer: #{polymer}"
  p "polymer contains #{polymer.length} units"
  p "done"
end
