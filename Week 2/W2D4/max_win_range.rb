def windowed_max_range(arr, window_size)
  # O(n^2)
  curr_max_range = nil
  num_windows = arr.length - window_size + 1

  num_windows.times do |i|
    window = arr.slice(i, window_size)
    range = window.max - window.min

    if curr_max_range.nil?
      curr_max_range = range
    elsif range > curr_max_range
      curr_max_range = range
    end
  end

  curr_max_range
end
