require('byebug')
def addr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] + input[b]
  output
end

p "expected: [3, 7, 4, 5] actual: #{addr([3, 2, 4, 5], [9, 0, 2, 1])}"

def addi(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] + b
  output
end

p "expected: [3, 5, 4, 5] actual: #{addi([3, 2, 4, 5], [9, 0, 2, 1])}"

def mulr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] * input[b]
  output
end

p "expected: [3, 12, 4, 5] actual: #{mulr([3, 2, 4, 5], [9, 0, 2, 1])}"

def muli(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] * b
  output
end

p "expected: [3, 6, 4, 5] actual: #{muli([3, 2, 4, 5], [9, 0, 2, 1])}"

def banr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] & input[b]
  output
end

p "expected: [3, 0, 4, 5] actual: #{banr([3, 2, 4, 5], [9, 0, 2, 1])}"

def bani(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] & b
  output
end

p "expected: [3, 2, 4, 5] actual: #{bani([3, 2, 4, 5], [9, 0, 2, 1])}"

def borr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] | input[b]
  output
end

p "expected: [3, 7, 4, 5] actual: #{borr([3, 2, 4, 5], [9, 0, 2, 1])}"

def bori(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] | b
  output
end

p "expected: [3, 3, 4, 5] actual: #{bori([3, 2, 4, 5], [9, 0, 2, 1])}"

def setr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a]
  output
end

p "expected: [3, 3, 4, 5] actual: #{setr([3, 2, 4, 5], [9, 0, 2, 1])}"

def seti(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = a
  output
end

p "expected: [3, 0, 4, 5] actual: #{seti([3, 2, 4, 5], [9, 0, 2, 1])}"

def gtir(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = a > input[b] ? 1 : 0
  output
end

p "expected: [3, 0, 4, 5] actual: #{gtir([3, 2, 4, 5], [9, 0, 2, 1])}"

def gtri(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] > b ? 1 : 0
  output
end

p "expected: [3, 1, 4, 5] actual: #{gtri([3, 2, 4, 5], [9, 0, 2, 1])}"

def gtrr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] > input[b] ? 1 : 0
  output
end

p "expected: [3, 0, 4, 5] actual: #{gtrr([3, 2, 4, 5], [9, 0, 2, 1])}"

def eqir(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = a == input[b] ? 1 : 0
  output
end

p "expected: [3, 0, 4, 5] actual: #{eqir([3, 2, 4, 5], [9, 0, 2, 1])}"

def eqri(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] == b ? 1 : 0
  output
end

p "expected: [3, 0, 4, 5] actual: #{eqri([3, 2, 4, 5], [9, 0, 2, 1])}"

def eqrr(input, instructions)
  output = input.dup
  _op_code, a, b, c = instructions
  output[c] = input[a] == input[b] ? 1 : 0
  output
end

p "expected: [3, 0, 4, 5] actual: #{eqrr([3, 2, 4, 5], [9, 0, 2, 1])}"

OPERATIONS = [:addr, :addi, :mulr, :muli, :banr, :bani, :borr, :bori, :setr, :seti, :gtir, :gtri, :gtrr, :eqir, :eqri, :eqrr]

def potential_ops(before, after, instructions)
  OPERATIONS.select { |op| self.send(op, before, instructions) == after }
end

p potential_ops([3,2,1,1], [3,2,2,1], [9,2,1,2])

def samples_with_three_or_more_ops
  samples = File.readlines('./input.txt').each_slice(4).to_a.map do |sset|
    before_str, instruction_str, after_str = sset
    before = before_str.scan(/(?<=\[)(.*?)(?=\])/).first.first.split(",").map(&:to_i)
    instructions = instruction_str.split(" ").map(&:to_i)
    after = after_str.scan(/(?<=\[)(.*?)(?=\])/).first.first.split(",").map(&:to_i)
    [before, after, instructions]
  end
  samples.select do |sample|
    before, after, instructions = sample
    potential_ops(before, after, instructions).length >= 3
  end.length
end

def op_code_to_operation
  codes_to_op = {}
  samples = File.readlines('./input.txt').each_slice(4).to_a.map do |sset|
    before_str, instruction_str, after_str = sset
    before = before_str.scan(/(?<=\[)(.*?)(?=\])/).first.first.split(",").map(&:to_i)
    instructions = instruction_str.split(" ").map(&:to_i)
    after = after_str.scan(/(?<=\[)(.*?)(?=\])/).first.first.split(",").map(&:to_i)
    [before, after, instructions]
  end
  samples = samples.map do |sample|
    before, after, instructions = sample
    op_code = instructions.first
    { op_code => potential_ops(before, after, instructions) }
  end
  potential_ops = OPERATIONS.reject { |op| codes_to_op.values.include?(op) }
  until codes_to_op.keys.length == OPERATIONS.length
    (0..15).each do |code|
      next if codes_to_op[code]
      code_samples = samples.select { |sample| sample[code] }
      code_sample_ops = code_samples.map { |sample| sample[code] }
      ops = potential_ops.select { |op|  code_sample_ops.all? { |code_ops| code_ops.include?(op) } }
      codes_to_op[code] = ops.first if ops.length == 1
      potential_ops = OPERATIONS.reject { |op| codes_to_op.values.include?(op) }
    end
  end
  codes_to_op
end

p samples_with_three_or_more_ops
p op_code_to_operation
