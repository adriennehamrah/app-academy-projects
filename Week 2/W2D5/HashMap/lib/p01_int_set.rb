class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    return true if validate!(num)
  end

  def validate!(num)
    unless num.between?(0, @store.length)
      raise 'Out of bounds'
    else
      true
    end
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # return false if include?(num)

    unless self.include?(num)
      if count >= num_buckets
        resize!
      end
      bucket = self[num]
      @store[bucket] << num
      @count += 1
    end

  end

  def remove(num)
    bucket = self[num]
    @count -= 1 if @store[bucket].delete(num)

  end

  def include?(num)
    bucket = self[num]
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @store.size
  end

  def num_buckets
    @store.length
  end

  def resize!
    resized = Array.new(num_buckets*2) {Array.new}
    @store.each do |bucket|

      bucket.each do |num|
        bucket = num % resized.size
        resized[bucket] << num
      end
    end
    @store = resized
  end
end
