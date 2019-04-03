bottles = 99;
while bottles != 0
	puts bottles.to_s + " bottles of beer on the wall, " + bottles.to_s + " bottles of beer."
	bottles = bottles - 1;
		if bottles != 0
			puts "Take one down and pass it around, " + bottles.to_s + " bottles of beer on the wall."
			puts " "
		else
			puts "Take one down and pass it around, no more bottles of beer on the wall."
			puts " "
			puts "No more bottles of beer on the wall, no more bottles of beer."
			puts "Go to the store and buy some more, 99 bottles of beer on the wall."
		end
end