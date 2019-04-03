class OrangeTree

	def initialize
		@height = 0
		@fruit = 0
		@age = 0
		puts "New Orange tree planted!"
	end

	def height
		puts "The tree is " + @height.to_s + " feet tall"
	end

	def oneYearPasses
		puts "One year passes"
		@age += 1
		@height += 1
		if @age < 2
			@fruit = 0
		else
			@fruit = @age * 5
		end

		if dead?
			puts "The orange tree dies"
			exit
		end
	end

	def countTheOranges
		puts "There are " + @fruit.to_s + " oranges in the tree"
	end

	def pickAnOrange
		if @fruit < 1
			puts "You ate all the oranges this year."
		else
			puts "Picked an orange from the tree. It's delicious!"
			@fruit -= 1
		end
	end

	private

	def dead?
		return @age > 5
	end


end


tree = OrangeTree.new
tree.height
tree.countTheOranges
tree.pickAnOrange

tree.oneYearPasses
tree.height
tree.countTheOranges
tree.pickAnOrange

tree.oneYearPasses
tree.height
tree.countTheOranges
tree.pickAnOrange

tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.height
tree.countTheOranges
tree.pickAnOrange

tree.oneYearPasses

