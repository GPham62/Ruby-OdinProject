require './lib/calculator'
RSpec.describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#multiply" do
    it "return the multiplication of more than 2 numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2, 3, 4)).to eql(24)
    end
  end

  describe "#subtract" do
    it "return the subtraction of more than 2 numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(2, 3, 4)).to eql(-5)
    end
  end

  describe "#divide" do
    it "return the division of more than 2 numbers" do
      calculator = Calculator.new
      expect(calculator.divide(8, 4, 2)).to eql(1)
    end
  end
end