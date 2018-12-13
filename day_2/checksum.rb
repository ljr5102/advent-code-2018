def checksum
  multiples = { contains_two: 0, contains_three: 0 }
  File.open('./input.txt').each do |box_id|
    char_counts = count_chars(box_id)
    multiples[:contains_two] += 1 if contains_two?(char_counts)
    multiples[:contains_three] += 1 if contains_three?(char_counts)
  end
  multiples[:contains_two] * multiples[:contains_three]
end

def count_chars(box_id)
  counts = Hash.new(0)
  box_id.each_char do |char|
    counts[char] += 1
  end
  counts
end

def contains_two?(char_counts)
  char_counts.values.include?(2)
end

def contains_three?(char_counts)
  char_counts.values.include?(3)
end

p "calculating checksum"
p checksum
p "done"
