# Generated by AtcoderGreedy on 2018-04-21
# ARC096 C
# Your code here

A, B, C, X, Y = gets.chomp.split(' ').map(&:to_i)

if A + B <= C * 2
  puts(A * X + B * Y)
  exit 0
end

needed_and_price = [[X, A], [Y, B]].sort

ret = 0
ret += needed_and_price[0][0] * C * 2


the_price = needed_and_price[1][1]
the_amount = needed_and_price[1][0] - needed_and_price[0][0]

ret += [C*2, the_price].min * the_amount

puts ret