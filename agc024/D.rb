# Generated by AtcoderGreedy on 2018-05-20
# AGC024 D
# Your code here

def read_stdin
  n = gets.chomp.to_i
  edges = []
  (n - 1).times do
    edges << gets.chomp.split(' ').map(&:to_i)
  end
  [n, edges]
end

N, edges = read_stdin

# require 'gviz'
# Graph do
#   edges.each do |a, b|
#     add a => b
#   end
#   save N
# end

def convert_graph(edges)
  ret = {}
  N.times do |i|
    ret[i+1] = []
  end
  edges.each do |a,b|
    ret[a] << b
    ret[b] << a
  end
  ret
end

g = convert_graph edges

lp = g.longest_path

s = lp.size

if s % 2 == 0
  r1, r2 = begin
             mid = s / 2
             lp[(mid-1)..mid]
           end
  depth = {r1 => 0, r2 => 0}
  degree = {}
  stack = []

  r1_adjs = g[r1].reject { |n| n == r2 }
  r2_adjs = g[r2].reject { |n| n == r1 }
  stack += r1_adjs.map { |n| [n, r1] }
  stack += r2_adjs.map { |n| [n, r2] }

  degree[r1] = r1_adjs.size
  degree[r2] = r2_adjs.size

  while !stack.empty?
    v, prev = stack.pop
    depth[v] = depth[prev] + 1
    adjs = g[v].reject { |n| n == prev }
    degree[v] = adjs.size
    stack += adjs.reject { |adj| depth.key? adj }.map { |adj| [adj, v] }
  end

  leaves = g.vertices
    .group_by { |v| depth[v] }
    .map do |d, vs|
    vs.map { |v| degree[v] }.max
  end.reduce(1,:*)

  puts "#{s / 2} #{leaves}"
  exit 0
end
