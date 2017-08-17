require_relative 'stacks_and_queues'

def slow_max_windowed_range(arr, window_size)
  # Time complexity = O(n^2)
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


def max_windowed_range(arr, window_size)
  # O(n)
  curr_max_range = nil
  queue = MaxMinStackQueue.new

  arr.each do |el|
    queue.enqueue(el)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      range = queue.max - queue.min
      curr_max_range = range if !curr_max_range || curr_max_range < range
    end
  end

  curr_max_range
end
