
def read_matrix(c)
  ret = []
  c.times do
    ret << gets.chomp.split(' ').map(&:to_i)
  end
  ret
end

N, C = gets.chomp.split(' ').map(&:to_i)
D = read_matrix(C)
c = read_matrix(N)

# $stderr.puts "(N, C) = (#{N}, #{C})"
# $stderr.puts D.inspect
# $stderr.puts c.inspect

groups = Array.new(3) do |_|
  (1..C).map do |color|
    [color, 0]
  end.to_h
end

# $stderr.puts groups.inspect

N.times do |i|
  N.times do |j|
    color = c[i][j]
    groups[(i + j) % 3][color] += 1
  end
end

colors_cands = (1..C).to_a.permutation 3

diffs = colors_cands.map do |colors|
  total = 0
  3.times do |i|
    to_color = colors[i]
    (1..C).each do |from_color|
      # $stderr.puts "from: #{from_color}, to: #{to_color}"
      total +=
        groups[i][from_color] * D[from_color - 1][to_color - 1]
    end
  end
  total
end

puts diffs.min
