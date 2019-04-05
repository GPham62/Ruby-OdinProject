def bubble_sort(array)
  for i in 0...array.length-1
    for j in 0...array.length-i-1
      if array[j] > array[j+1]
        array[j], array[j+1] = array[j+1], array[j]
      end
    end
  end
  array
end 

def bubble_sort_by array
    (array.length - 1).times do |x|
    if yield(array[x], array[x+1]) > 0
        array[x], array[x+1] = array[x+1], array[x]
      end
    end
  array
end

# print bubble_sort([4,3,78,2,0,2])

sortArray = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end

print sortArray