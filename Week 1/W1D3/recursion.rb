class Array
  def merge_sort
    return self if length <= 1 #TODO self[0]

    mid = self.mid_idx

    left_sorted = self[0...mid].merge_sort
    right_sorted = self[mid..-1].merge_sort

    merge(left_sorted, right_sorted)
  end

  def merge(left_sorted, right_sorted)
    sorted = []

    until left_sorted.empty? || right_sorted.empty?
      if left_sorted[0] >= right_sorted[0]
        sorted << right_sorted.shift
      else
        sorted << left_sorted.shift
      end
    end

    sorted + left_sorted + right_sorted
  end

  def mid_idx
    length/2
  end
end






def range(lo, hi)
  return [] if lo >= hi

  [lo] + range(lo + 1, hi)
end

def exp1(b, pow)
  pow.zero? ? 1 : b * exp1(b, pow - 1)
end

def exp2(b, pow)
  return 1 if pow.zero?
  return b if pow == 1

  even = exp2(b, pow / 2)**2

  if pow.even?
    even
  else
    b * even
  end
end

class Array
  def deep_dup
    duped = []
    self.each do |el|
      duped << (el.is_a?(Array) ? el.deep_dup : el)
    end
    duped
  end

  def deep_dup_map
    map { |el| el.is_a?(Array) ? el.deep_dup_map : el }
  end
end

def fib(n)
   if n <= 2
     [0, 1].take(n)
   else
     prev_fib = fib(n - 1)
     prev_fib << prev_fib[-2] + prev_fib[-1]
   end
end

class Array
  def subsets
    return [[]] if empty?

    small_sub = self.take(count - 1)
    small_subs = small_sub.subsets

    small_subs + small_subs.map {|sub| sub + [last]}

    # small_subs.each do |sub|
    #   big_subs << sub + [self.last]
    # end
    # small_subs + big_subs
  end
end

def my_perm(arr)
  res = []
  return [arr] if arr.length <= 1

  length.times do
    first = arr[0]
    res += arr[1..-1].my_perm.map { |perm| [first] + perm }
    arr.rotate!
  end
  res
end


NON_MATCH = nil
def bsearch(arr, val)
  if self.count(NON_MATCH) == self.length - 1
    idx = first_valid_index(val.class)
    return match?(idx, val) ? val : nil
  end

  arr = self.dup
  mid = arr.valid_midpoint(val.class)
  return mid if arr.match?(mid, val)

  if val < arr[mid]
    lo_nil, hi_nil = [mid, arr.length - 1]
  else
    lo_nil, hi_nil = [0, mid]
  end

  arr.nil_out_range(lo_nil, hi_nil)
  arr.bsearch(val)
end

def nil_out_range(lo, hi)
  lo.upto(hi) { |idx| self[idx] = nil }
end

def match?(idx, val)
  self[idx] == val
end

def valid_midpoint(valid_class)
  indices = valid_range(valid_class)
  (indices[0] + indices[1]) / 2
end

def valid_range(valid_class)
  [first_valid_index(valid_class), last_valid_index(valid_class)]
end

def first_valid_index(valid_class)
  index { |el| el.is_a?(valid_class) }
end

def last_valid_index(valid_class)
  rindex { |el| el.is_a?(valid_class) }
end
