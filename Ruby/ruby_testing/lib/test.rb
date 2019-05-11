def hey(*arg)
  arg.each do |element|
    print element
  end
end

hey("a", "b", "c")