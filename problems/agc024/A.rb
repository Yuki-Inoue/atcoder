# Generated by AtcoderGreedy on 2018-05-20
# AGC024 A
# Your code here

a, b, c, k = gets.chomp.split(' ').map(&:to_i)

a_b = a - b

if a_b.abs > 1_000_000_000_000_000_000
  puts 'Unfair'
else
  a_b *= -1 if k % 2 != 0
  puts a_b
end