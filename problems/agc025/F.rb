#!/usr/bin/env ruby

# Generated by AtcoderGreedy on 2018-06-03
# AGC025 F

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
    if amount < 0
      raise ArgumentError, "amount == #{amount}, cannot be negative!"
    end
    take_amount = size - amount
    take_amount < 0 ? [] : take(take_amount)
  end
end

def n_choose_k(n, k)
  return 0 unless (0..n).cover? k
  result = 1
  1.upto(k) do |d|
    result *= n
    result /= d
    n -= 1
  end
  result
end

# end of lib

# Your code here
