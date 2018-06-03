#!/usr/bin/env ruby

# Generated by AtcoderGreedy on 2018-06-03
# AGC025 C

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

require 'set'

N = gets.chomp.to_i
LR = Struct.new(:l, :r)

ranges = []
N.times do |i|
  ranges.push gets.chomp.split(' ').map(&:to_i)
end
LRS = ranges

# N = 3
# LRS = [
#   [-5, 1],
#   [3, 7],
#   [-4, -2]
# ]

class Lines
  def initialize
    @lefts = SortedSet.new \
                        (LRS.map do |lr|
                           [-lr[0], lr]
                         end)

    def @lefts.remove_pair(obj)
      delete [-obj[0], obj]
    end

    @rights = SortedSet.new \
                         (LRS.map do |lr|
                            [lr[1], lr]
                          end )

    def @rights.remove_pair(obj)
      delete [obj[1], obj]
    end
  end

  attr_reader :rights, :lefts

  def pop(lefts_or_rights)
    pair = send(lefts_or_rights).first[1]
    lefts.remove_pair pair
    rights.remove_pair pair
    pair
  end
end

def iteration(left_or_right)
  current = 0
  current_take_dir = left_or_right

  lines = Lines.new

  ret = 0
  N.times do
    # require 'pry'
    # binding.pry
    if current_take_dir == :left
      pair = lines.pop(:lefts)
      if current < pair[0]
        ret += pair[0] - current
        current = pair[0]
      end
      current_take_dir = :right
    else
      pair = lines.pop(:rights)
      if current > pair[1]
        ret += current - pair[1]
        current = pair[1]
      end
      current_take_dir = :left
    end
  end
  if current != 0
    ret += current.abs
  end
  ret
end


left = iteration(:left)
right = iteration(:right)

puts [left, right].min
