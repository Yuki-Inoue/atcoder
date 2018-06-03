# Generated by AtcoderGreedy on 2018-04-21
# ARC096 D
# Your code here

def input_stdin
  n, c = gets.chomp.split(' ').map(&:to_i)
  sushis = []
  n.times do
    sushis << gets.chomp.split(' ').map(&:to_i)
  end
  [n, c, sushis]
end

def input_example1
  require 'pry-byebug'
  require 'pry'
  [3, 20,
   [[2, 80],
    [9, 1],
    [16, 120]]]
end

def input_example0
  require 'pry-byebug'
  require 'pry'
  [3, 20,
   [[2, 80],
    [9, 120],
    [16, 1]]]
end

N, C, sushis = input_stdin

class Problem
  def initialize(sushis, counterpart = nil)
    @sushis = sushis
    @counterpart = counterpart
  end
  attr_reader :sushis

  def counterpart
    @counterpart ||=
      begin
        self.class.new(
          sushis.map { |x, v| [C - x, v] }.sort,
          self
        )
      end
  end

  def candidates
    @candidates ||=
      begin
        ans = [[0, 0]]
        sushis.each do |x, v|
          prev_x, prev_v = ans.last
          ans << [x, prev_v + v - (x - prev_x)]
        end
        ans.map { |x| x[1] }
      end
  end

  def maxes
    @maxes ||=
      begin
        ret = []
        ret << candidates.first
        candidates.drop(1).each do |cand|
          ret << [ret.last, cand].max
        end
        ret
      end
  end

  def find_best
    cands = candidates.drop(1).map.with_index do |cand, i|
      x, v = sushis[i]
      cand + counterpart.maxes[N - i - 1] - x
    end
    [cands.max, counterpart.maxes[N]].max
  end
end


pair_world = Problem.new(sushis)

binding.pry if binding.respond_to? :pry

normal_best = pair_world.find_best
counter_best = pair_world.counterpart.find_best

puts [normal_best, counter_best].max