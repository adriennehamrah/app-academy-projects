class Array
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if length <= 1

    mid = length/2
    left_sorted = self.take(mid).merge_sort(&prc)
    right_sorted = self.drop(mid).merge_sort(&prc)

    merge(left_sorted, right_sorted, &prc)
  end

  def merge(left_sorted, right_sorted, &prc)
    sorted = []

    until left_sorted.empty? || right_sorted.empty?
      case prc.call(left_sorted[0], right_sorted[0])
      when -1
        sorted << left_sorted.shift
      when 0
        sorted << left_sorted.shift
      when 1
        sorted << right_sorted.shift
      end
    end

    sorted + left_sorted + right_sorted
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
  return [0,1].take(n) if n < 2

  prev_fib = fib(n-1)
  prev_fib << prev_fib[-2] + prev_fib[-1]
end

class Array
  def subsets
    return [[]] if empty?

    small_sub = self.take(count - 1)
    small_subs = small_sub.subsets

    small_subs + small_subs.map {|sub| sub + [last]}
  end
end

def my_perm(arr)
  return [[]] if empty?

  res = []

  length.times do
    first = arr[0]
    res += arr[1..-1].my_perm.map { |perm| [first] + perm }
    arr.rotate!
  end
  res
end

def bsearch(arr, val)
  return nil if arr.empty?

  mid_idx = arr.size/2

  if val < arr[mid_idx]
    bsearch(arr[0...mid_idx], val)
  elsif val == arr[mid_idx]
    mid_idx
  else
    sub_ans = bsearch(arr[mid_idx+1..-1], val)
    (sub_ans.nil?) ? nil : (mid_idx + sub_ans + 1)
  end
end
