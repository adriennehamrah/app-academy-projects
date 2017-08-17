def bad_two_sum?(arr, num)
  # time complexity is O(n^2)
  arr.each_with_index do |el, idx|
    arr.each_with_index do |el2, idx2|
      next if idx == idx2
      return true if el + el2 == num
    end
  end
  false
end

def okay_two_sum?(arr, num)
  # O(nlog(n))
  arr = arr.sort
  smaller_arr = []
  arr.each do |el|
    break if el >= num
    smaller_arr << el
  end

  smaller_arr.each_with_index do |el, idx|
    target = num - el
    search_array = arr.dup
    search_array.delete_at(idx)
    return true if search_array.bsearch { |el| el == target }
  end

  false
end

def hash_two_sum?(arr, num)
  # O(n)
  hsh = {}

  arr.each do |el|
    hsh[el] = num - el
  end

  arr.each do |el|
    return true if hsh.has_value?(el)
  end

  false
end
