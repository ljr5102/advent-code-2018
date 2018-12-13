def common_ids
  box_ids = File.readlines('./input.txt').map(&:strip)
  box_ids.each_with_index do |current_id, idx|
    box_ids[(idx + 1)...box_ids.length].each do |compare_id|
      mismatches = 0
      common_string = ""
      current_id.each_char.with_index do |current_char, char_idx|
        if current_char == compare_id[char_idx]
          common_string << current_char
        else
          mismatches += 1
        end
        break if mismatches == 2
      end
      next if mismatches == 2
      return common_string
    end
  end
end

p "finding common ids"
p common_ids
p "done"
