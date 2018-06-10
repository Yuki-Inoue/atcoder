#!/usr/bin/env ruby
a, b = gets.chomp.split(' ').map(&:to_i)

c = b - a

b_height = (1..c).reduce(&:+)
snow = b_height - b

puts snow
