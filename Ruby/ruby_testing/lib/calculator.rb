class Calculator
  def add(*nums)
    sum = 0
    nums.each do |num|
      sum += num
    end
    sum
  end

  def multiply(*nums)
    res = 1
    nums.each do |num|
      res *= num
    end
    res
  end

  def subtract(first_num, *nums)
    nums.inject(first_num){|mem, var| mem - var}
  end

  def divide(first_num, *nums)
    raise "divide error" if first_num == 0
    nums.inject(first_num){|mem, var| mem / var}
  end
end