#!/usr/bin/env ruby

class Range
  def &(other)
    a = to_closed
    b = other.to_closed
    ([a.first, b.first].max..[a.last, b.last].min)
  end

  def to_closed
    return self unless exclude_end?
    (first..(last - 1))
  end

  def superset_of?(other)
    a = to_closed
    b = other.to_closed
    a.first <= b.first && a.last >= b.last
  end

  def subset_of?(other)
    other.superset_of? self
  end

  def empty?
    !(any? { |_| true })
  end
end

class SegTree
  def initialize(arr, reducer)
    ret = [arr]
    l = arr.size
    l /= 2
    while l > 0
      cand = []
      prev = ret.last
      l.times do |i|
        cand << reducer.call(prev[2*i], prev[2*i+1])
      end
      ret << cand
      l /= 2
    end
    @tree = ret
    @reducer = reducer
  end

  def cover_of(h, i)
    l = 2**h
    (l * i)..(l * (i + 1) - 1)
  end

  def reduced_value_of_sub(h, range, i = 0)
    h_range = cover_of h, i
    return nil if (range & h_range).empty?
    return @tree[h][i] if range.superset_of? h_range
    cand1 = reduced_value_of_sub(h-1, range, i*2)
    cand2 = if i*2+1 < @tree[h-1].size
              reduced_value_of_sub(h-1, range, i*2+1)
            end
    cands = [cand1, cand2].reject(&:nil?)
    return nil if cands.empty?
    cands.reduce(&@reducer)
  end

  def value_of(range)
    range = range.to_closed
    h = log2_ceil(range.last + 1)
    reduced_value_of_sub(h, range)
  end

  def log2_ceil(n)
    n = n.to_i
    ret = 0
    while n > 0
      n /= 2
      ret += 1
    end
    ret
  end
end
