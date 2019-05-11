require './project_enumerableMethods'

describe Enumerable do
  describe "#my_each" do
    it "returns the receiver of my_each" do
      expect([1, 2, 3].my_each { |n| n }).to eql([1, 2, 3])
    end

    it "returns the enumerator of the receiver" do
      expect([1, 2, 3].my_each).to be_an enumerator
      expect([1, 2, 3].my_each.to_a).to eql([1, 2, 3])
    end
  end

  describe "#my_select" do
    it "returns a new array with all the even numbers of the receiver." do
      expect([10, 25, 50, 101].my_select { |n| n.even? }).to eql([10, 50])
    end

    it "returns a new array containing strings of the reciever which contain a specified letter." do
      expect(["apple", "fox", "advent", "igloo", "fantasy"].my_select { |w| w =~ /a/ }).to eql(["apple", "advent", "fantasy"])
    end
  end

  describe "#my_all?" do
    it "returns 'true' on an empty array (or when all there are no elements that are 'false' or 'nil'." do
      expect([].my_all?).to eql(true)
    end

    it "returns 'false' when an 1 element evaluates to 'false' based on the block passed in." do
      expect([100, 200, 300].my_all? { |n| n > 100 }).to eql(false)
    end
  end

  describe "#my_any?" do
    it "returns 'false' if no block is passed in and the reciever is empty." do
      expect([].my_any?).to_not eql(true)
    end

    it "returns 'true' if a block is passed in, and no element in the reciever evaluates to 'false' or 'nil' based on the block condition." do
      expect([10, 20, 30, 40].my_any? { |n| n < 11 }).to eql(true)
    end

    it "returns 'false' if no elements in the receiver evaluates tp 'false' or 'nil' based on the block conditions." do
      expect([100, 200, 300].my_any? { |n| n > 300 }).to eql(false)
    end
  end

  describe "#my_map" do
    it "returns an array where the elements have been operated on in some way, based on the block passed in." do
      expect([1, 2, 3, 4].my_map { |n| n * 10 }).to eql([10, 20, 30, 40])
    end

    it "returns an array where the elements have been operated on in some way, based on a proc passed in." do
      subtract_10 = Proc.new { |n| n - 10}
      expect([1, 2, 3, 4, 5].my_map(&subtract_10)).to eql([-9, -8, -7, -6, -5])
    end
  end

  describe "#my_inject" do
    it "returns the sum of all the receiver's elements." do
      expect([100, 200, 300].my_inject { |sum, n| sum + n }).to eql(600)
    end

    it "returns the subtracted total of all the receiver's elements, where the starting total is the first element." do
      expect([100, 200, 300].my_inject { |sum, n| sum - n }).to eql(-400)
    end

    it "returns the multiplied total of all the receiver's elements, where the starting total is the first element." do
      expect([10, 2, 45].my_inject { |sum, n| sum * n }).to eql(900)
    end

    it "returns the quotient of all the receiver's elements, where the starting total is the first element." do
      expect([100, 5, 2].my_inject { |sum, n| sum / n }).to eql(10)
    end

    it "returns the sum of all the receiver's elements, where the starting total is the first element,by passing in a symbol." do
      expect([100, 5, 2].my_inject(:+)).to eql(107)
    end

    it "returns a sum of all the receiver's elements, where the starting total is passed as an argument, with a symbol as an element." do
      expect([100, 5, 2, 47].my_inject(1000, :+)).to eql(1154)
    end

    it "returns a sum of all the receiver's elements, where the starting total is passed as an argument, and a block is passed in." do
      expect([100, 5, 2, 47].my_inject(1000) {|total, n| total + n}).to eql(1154)
    end

    it "returns a hash with all the receiver's elements, where the hash is passed as an argument." do
      expect([1, 2, 3, 4].inject({}) {|hash, n| hash[n.to_s] = n; hash}).to eql({"1" => 1, "2" => 2, "3" => 3, "4" => 4})
    end
  end

end