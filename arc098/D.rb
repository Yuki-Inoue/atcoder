# Generated by AtcoderGreedy on 2018-05-26
# ARC098 D
# Your code here

N = gets.chomp.to_i
A = gets.chomp.split(' ').map(&:to_i)

Span = Struct.new(:head, :tail, :xor) do
  def self.singleton(i)
    new(i, i, A[i])
  end

  def drop
    self.class.new(head + 1, tail, xor - A[head])
  end

  def append(i)
    current = self
    current = current.drop while current.xor & A[i] != 0
    self.class.new(current.head, current.tail + 1, current.xor + A[i])
  end
end

current = Span.singleton(0)

ret = 1

(1...N).map do |i|
  current = current.append i
  ret += current.tail - current.head + 1
end

puts ret
