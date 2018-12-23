require('byebug')
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
  scores = [3, 7]

  number_to_arr = number.to_s.split("").map(&:to_i)
  until scores[-number_to_arr.length..-1] == number_to_arr
    new_recipes = (scores[elf_one[:index]] + scores[elf_two[:index]]).to_s.split("").map(&:to_i)
    scores = scores.concat(new_recipes)
    elf_one[:index] = ((scores[elf_one[:index]] + 1) + elf_one[:index]) % scores.length
    elf_two[:index] = ((scores[elf_two[:index]] + 1) + elf_two[:index]) % scores.length
  end
  scores.join('').index(number.to_s)
end

p "expected: 5158916779 actual: #{recipe_scores_after(9)}"
p "expected: 0124515891 actual: #{recipe_scores_after(5)}"
p "expected: 9251071085 actual: #{recipe_scores_after(18)}"
p "expected: 5941429882 actual: #{recipe_scores_after(2018)}"
p "expected: 2157138126 actual: #{recipe_scores_after(894501)}"

p "expected: 9 actual: #{recipe_scores_before(51589)}"
p "expected: 5 actual: #{recipe_scores_before(01245)}"
p "expected: 18 actual: #{recipe_scores_before(92510)}"
p "expected: 2018 actual: #{recipe_scores_before(59414)}"
p recipe_scores_before(894501)

# 14815 incorrect
