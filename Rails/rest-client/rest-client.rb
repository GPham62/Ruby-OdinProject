require 'rest-client'

puts "Welcome to Bing Search"

loop do
  puts "Type in word to search('quit' to quit):"
  word = gets.chomp.to_s
  break if word == 'quit'
  url = 'https://www.bing.com'
  response = RestClient.get url, {params: {q: word}}
  result = {}
  response.body.scan(/<h2><a.*?href="(?<link>.*?)".*?h=.*?>(?<text>.*?)<\/a.*?>/) do |link, text|
    result[link] = text
  end

  count = 1
  result.each do |link, text|
    puts "#{count}. #{text}"
    puts "- - - Link: #{link} - - -"
    count += 1
  end
end