save_file = Dir.open("./project_mastermind/")
puts "Show:"

Dir.foreach(save_file) {|file| file.length > 5? print("    #{file.split(".")[0]}\n") : "" }