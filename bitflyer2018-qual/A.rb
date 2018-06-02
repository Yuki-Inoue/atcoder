#!/usr/bin/env ruby

# Generated by AtcoderGreedy on 2018-06-02
# BITFLYER2018-QUAL A

# my lib

module Enumerable
  # work just like String#split,
  # except this method does not use regex match
  # but check whether yield succeeds or not.
  def split
    current = nil
    ret = []
    each do |elem|
      if yield elem
        if current
          ret << current
          current = nil
        end
      elsif current
        current << elem
      else
        current = [elem]
      end
    end
    ret << current if current
    ret
  end
end

class Array
  # truncate tail, opposite of drop
  def clip(amount = 1)
    take_amount = size - amount
    take_amount < 0 ? [] : take(take_amount)
  end
end

# end of lib

# Your code here

A = gets.chomp.to_i
B = gets.chomp.to_i

puts (A / B) * B
