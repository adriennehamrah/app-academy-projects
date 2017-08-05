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

  def my_flatten
    arr = []
    self.my_each do |el|
      if el.is_a?(Array)
        arr += el.my_flatten
      else
        arr << el
      end
    end
    arr
  end

  def my_zip(*args)
    res = Array.new(self.length) { Array.new }

    self.each_with_index do |el, i|
      res[i] << el
      args.each { |arr| res[i] << arr[i] }
    end
    res
  end

  def my_rotate(offset = 1)
    newarr = self
    if offset > 0
      offset.times do
        to_back = newarr.shift
        newarr.push(to_back)
      end
    else
      offset.abs.times do
        to_front = newarr.pop
        newarr.unshift(to_front)
      end
    end
    newarr
  end

  def my_join(sep = '')
    str = ''
    self.my_each do |el|
      str << el + sep
    end
    if sep == ''
      str
    else
      str[0..-2]
    end
  end

  def my_reverse
    i = self.length - 1
    arr = []
    while i >= 0
     arr << self[i]
      i -= 1
    end
    arr
  end
end
