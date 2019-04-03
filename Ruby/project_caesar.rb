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
						if pointer > alphabetUpcase.length
							pointer = pointer - alphabetUpcase.length - 1
						end
						splitString[index] = alphabetUpcase[pointer]
					end
				end
			else
				for i in (0..alphabet.length)
					if character == alphabet[i]
						pointer = i + key
						if pointer > alphabet.length
							pointer = pointer - alphabet.length - 1
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

puts caesar_cipher("What a String !", 1)