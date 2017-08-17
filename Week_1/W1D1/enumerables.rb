class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    res = []
    self.my_each do |el|
      res << el if prc.call(el)
    end
    res
  end

  def my_reject(&prc)
    res = []
    self.my_each do |el|
      res << el unless prc.call(el)
    end
    res
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_flatten
    flattened = []

    self.each do |el|
      if el.is_a?(Array)
        flattened += el.my_flatten
      else
        flattened << el
      end
    end

    flattened
  end

  def my_zip(*args)
    arr = []

    self.each_index do |i|
      arr << [self[i]]
      arr[i].concat(arrs.map { |arr| arr[i] })
    end

    arr
  end

  def my_rotate(offset = 1)
    new_offset = offset % self.size

    new_offset.times do
      self << self.shift
    end
    self
  end

  def my_join(sep = '')
    joined = ''
    size.times do |i|
      joined << self[el]
      joined << sep unless i == self.size - 1
    end

    str
  end

  def my_reverse
    #  # iterative
    #   reversed = []
    #   self.length.times do
    #     reversed << self.pop
    #   end
    #   reversed

    # recursive
    return self if size < 2
    first = self.pop
    [first] + self.my_reverse
  end
end
