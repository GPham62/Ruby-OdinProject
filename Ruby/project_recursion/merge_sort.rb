def merge_sort(array)
  return array if array.size < 2
  left = merge_sort(array.slice!(0, array.size / 2))
  right = merge_sort(array)
  sort_array = []
  (left.size + right.size).times do
    if left.empty?
      sort_array << right.shift
    elsif right.empty?
      sort_array << left.shift
    elsif left[0] < right[0]
      sort_array << left.shift
    else
      sort_array << right.shift
    end
  end
  sort_array
end
array = [1,3,5,7,2,4,6,10, 8, 11, 9, 6]
print merge_sort(array)
