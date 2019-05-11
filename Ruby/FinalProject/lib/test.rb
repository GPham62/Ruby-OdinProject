class A
  attr_accessor :color
  def initialize
    @color = "black"
  end

  def temp
    puts @color
  end
end

a = A.new
a.color = "green"
b = A.new
b.color = "red"
puts a.temp
puts b.temp