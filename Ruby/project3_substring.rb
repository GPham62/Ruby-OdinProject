def substrings(string, dictionary)
  result = {}
  dictionary.each_with_index do |word, i|
    if string.downcase.include?(word)
      result[word] = string.downcase.scan(word).length
    end
  end
  puts result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("Howdy partner, sit down! How's it going?", dictionary) 