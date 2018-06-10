MAX = 100_000

arr = { 0 => 0 }

def withdraws(base)
  ret = [base]
  cand = ret.last * base
  while cand <= MAX
    ret << cand
    cand = ret.last * base
  end
  ret
end

withds = [1] + withdraws(6) + withdraws(9)
withds = withds.sort

WITHDRAWS = withds

edges = [0]
n = 0

until edges.empty?
  n += 1
  next_edges = []
  edges.each do |e|
    WITHDRAWS.each do |w|
      next_ind = e + w
      break if next_ind > MAX
      unless arr[next_ind]
        arr[next_ind] = n
        next_edges << next_ind
      end
    end
  end
  edges = next_edges
end

N = gets.to_i
puts arr[N]
