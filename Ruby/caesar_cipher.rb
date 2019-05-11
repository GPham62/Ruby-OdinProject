require 'pry'
def caesar_cipher(encryptString, key)
	splitString = encryptString.split("")
	scriptedString = ""
	alphabet = ('a'..'z').to_a
	alphabetUpcase = ('A'..'Z').to_a
	splitString.each.with_index do |character, index|
		if letter?(character)
			if character == character.upcase
				for i in (0..alphabetUpcase.length)
					if character == alphabetUpcase[i]
						pointer = i + key
						while pointer.abs >= alphabetUpcase.length
              if pointer > 0
							 pointer -= alphabetUpcase.length
              else
                pointer += alphabetUpcase.length
              end
						end
						splitString[index] = alphabetUpcase[pointer]
					end
				end
			else
				for i in (0..alphabet.length)
					if character == alphabet[i]
						pointer = i + key
						while pointer.abs >= alphabet.length
							if pointer > 0
               pointer -= alphabet.length
              else
                pointer += alphabet.length
              end
						end
						splitString[index] = alphabet[pointer]
					end
				end
			end
		end
	end

	splitString.each do |e|
		scriptedString += e
	end
	return scriptedString
end

def letter?(string)
	return string =~ /[A-Za-z]/
end

print caesar_cipher("zebras", 27)
