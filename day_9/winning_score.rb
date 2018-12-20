def winning_score
  num_players, num_turns = File.open('./input.txt').read.scan(/\d+/).map(&:to_i)
  score = Hash.new(0)
  current_marble_idx = 0
  board = [0]
  current_player = 0
  current_marble_idx += 1
  1.upto(num_turns) do |marble_value|
    if board.length == 1
      board = [0, 1]
      current_marble_idx = 1
      current_player = (current_player + 1) % num_players
      next
    end
    if marble_value % 23 == 0
      score[current_player] += marble_value
      idx_to_remove = current_marble_idx - 7
      marble_value_to_remove = board[idx_to_remove]
      score[current_player] += marble_value_to_remove
      next_current_marble_value = board[idx_to_remove + 1]
      board.delete(marble_value_to_remove)
      current_marble_idx = board.index(next_current_marble_value)
    else
      outer = (current_marble_idx + 2) % board.length
      inner = (current_marble_idx + 1) % board.length
      if outer < inner
        board << marble_value
      else
        board = board[0..inner].concat([marble_value]).concat(board[outer..board.length - 1])
      end
      current_marble_idx = board.index(marble_value)
    end
    current_player = (current_player + 1) % num_players
  end
  score.max_by { |_k, v| v }[1]
end

p "finding elfs winning score"
p winning_score
p "done"
