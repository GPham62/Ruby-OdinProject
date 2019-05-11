require './caesar_cipher'

RSpec.describe "#caesar_cipher" do
  it "returns a word with alphanumeric characters shifted by a certain factor." do
    expect(caesar_cipher("hello", 10)).to eql("rovvy")
  end

  it "returns multiple words with aplhanumeric characters shifted by a certain factor, and ignores spaces." do
    expect(caesar_cipher("programming is fun", 1)).to eql("qsphsbnnjoh jt gvo")
  end

  it "returns a string with characters shifted by a negative shift factor." do
    expect(caesar_cipher("fight", -5)).to eql("adbco")
  end

  it "returns a string with characters shifted by a factor greater than 26, where if a character is shifted passed 'z', it resets to 'a'." do
    expect(caesar_cipher("zebras", 27)).to eql("afcsbt")
  end

  it "returns a string with characters shifted by a factor less than -26, where if a character is shifted passed 'a', it resets to 'z'." do
    expect(caesar_cipher("apple", -27)).to eql("zookd")
  end

  it "returns a string with alphanumeric characters shifted by a certain factor, and ignores punctuation." do
    expect(caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
  end
end