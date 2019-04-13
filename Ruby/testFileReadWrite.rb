# require 'rubygems'
# require 'rest-client'

# wiki_url = "http://en.wikipedia.org/"
# wiki_local_filename = "wiki-page.html"

# File.open(wiki_local_filename, "w") do |file|
#   file.write(RestClient.get(wiki_url))
# end

require 'open-uri'

url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"

local_file = "hamlet.txt"

File.open(local_file, "w"){|file| file.write(open(url).read)}

is_hamlet_speaking = false
File.open(local_file, "r") do |file|
   file.readlines.each do |line|

      if is_hamlet_speaking == true && ( line.match(/^  [A-Z]/) || line.strip.empty? )
        is_hamlet_speaking = false
      end

      is_hamlet_speaking = true if line.match("Ham\.")

      puts line if is_hamlet_speaking == true
   end   
end
