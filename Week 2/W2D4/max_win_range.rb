def windowed_max_range(arr, w)
  # O(n^2)
  current_max_range = 0
  arr.each_index do |idx|
    start = idx
    final = idx + w - 1
    break if final > arr.length - 1
    max = arr[start..final].max
    min = arr[start..final].min
    current_max_range = max - min if max - min > current_max_range
  end
  current_max_range
end
