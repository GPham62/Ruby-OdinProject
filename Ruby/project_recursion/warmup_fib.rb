def fibs_iteration(n)
  (0..n).each_with_object([]) do |i, array|
    if i < 2
      array << i
    else
      next_val = array[-1] + array[-2]
      array << next_val
    end
  end
end

# print fib_iteration(10)

def fibs_rec(n)
  return 0 if n == 0
  return 1 if n == 1
  return fibs_rec(n-1) + fibs_rec(n-2)
end

print fibs_rec(10)