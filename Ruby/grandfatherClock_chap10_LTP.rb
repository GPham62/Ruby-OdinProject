def clock(doProc)
	hourNow = Time.now.hour
	if hourNow == 0
		hourNow = hourNow + 12
	elsif hourNow > 12
		hourNow = hourNow - 12
	end

	hourNow.to_i.times do
		doProc.call
	end
end

chime = Proc.new do
	puts "DONG!"
end

def log(description, &block)
	puts "Beginning \"" + description + "\"..."
	puts "...\"" + description + "\" finished, returning: "
	block.call
end

log("some little block") do
	print "5"
end
