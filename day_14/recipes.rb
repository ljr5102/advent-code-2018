def recipe_scores_after(number = 9)
  elf_one = { index: 0 }
  elf_two = { index: 1 }
  scores = [3, 7]

  until scores.length >= number + 10
    new_recipes = (scores[elf_one[:index]] + scores[elf_two[:index]]).to_s.split("").map(&:to_i)
    scores = scores.concat(new_recipes)
    elf_one[:index] = ((scores[elf_one[:index]] + 1) + elf_one[:index]) % scores.length
    elf_two[:index] = ((scores[elf_two[:index]] + 1) + elf_two[:index]) % scores.length
  end
  scores[number..(number + 9)].join('')
end

def recipe_scores_before(number = 9)
  elf_one = { index: 0 }
  elf_two = { index: 1 }
  scores = { 0 => 3, 1 => 7 }

  idx = 2
  until (last_num_scores(idx, scores)).join('').include?(number.to_s)
    new_recipes = (scores[elf_one[:index]] + scores[elf_two[:index]]).to_s.split("").map(&:to_i)
    new_recipes.each do |recip|
      scores[idx] = recip
      idx += 1
    end
    elf_one[:index] = ((scores[elf_one[:index]] + 1) + elf_one[:index]) % scores.length
    elf_two[:index] = ((scores[elf_two[:index]] + 1) + elf_two[:index]) % scores.length
  end
  scores.values.join('').index(number.to_s)
end

def last_num_scores(idx, scores)
  arr = []
  (idx - 10).upto(idx) { |el| arr << scores[el] }
  arr.compact
end

p "finding scores after input"
p recipe_scores_after(894501)
p "done"
p "finding scores until input appears"
p recipe_scores_before(894501)
p "done"
