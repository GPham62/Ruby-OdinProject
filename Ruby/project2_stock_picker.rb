class Day
  attr_accessor :number, :value
  def initialize(number, value)
    @number = number
    @value = value
  end
end

def stock_picker(stocks)
  best_buy = Day.new(0,0)
  best_sell = Day.new(0,0)
  best_days = []
  difference = 0 # This represents the difference between buy and sell values.

  stocks.each_with_index do |stock, i| # s = stock value in array. i = index of value in array.
    stocks.drop(i+1).each.with_index(i+1) do |t, j| # The drop method allows us to skip some values before iterating. The each.with_index works the same for indexes.
      if stock - t < difference
        difference = stock - t
        best_buy.number = i
        best_buy.value = stock
        best_sell.number = j
        best_sell.value = t
      end
    end
  end

  if difference < 0
    best_days.push(best_buy)
    best_days.push(best_sell)

    return best_days
  end

  puts "The algorithm hasn't found any way to make a profit with given stock prices. Sorry !"
  exit
end

best_days = stock_picker([17,3,6,9,15,8,6,1,10])

puts "The best day to buy is : Day #{best_days[0].number} for a buy price of #{best_days[0].value}$"
puts "The best day to sell is : Day #{best_days[1].number} for a sell price of #{best_days[1].value}$"
puts "Total profit : #{best_days[1].value-best_days[0].value}$"