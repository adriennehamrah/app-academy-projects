def my_min_n2(arr)
  arr.each do |el1|
    smallest = true
    arr.each do |el2|
      smallest = false if el2 < el1
    end
    return el1 if smallest
  end
end

def my_min_n(arr)
  result = arr.first
  arr.each do |el|
    result = el if el < result
  end
  result
end

def largest_sub_sum_n3(arr)
  sub_arrays = []
  (0...arr.size - 1).each do |idx1|
    (idx1 + 1...arr.size).each do |idx2|
      sub_arrays << arr[idx1..idx2]
    end
  end
  sums = sub_arrays.map { |el| el.reduce(:+) }
  sums.max
end

def largest_sub_sum(arr)
  largest = 0
  running = 0

  arr.each do |el|
    running += el
    if running < 0
      running = 0
    end
    largest = running if running > largest
  end

  largest
end
