def first_anagram?(str1, str2)
  str1_letters = str1.chars
  str2_letters = str2.chars
  permutations = str1_letters.permutation.to_a

  permutations.include?(str2_letters)
end

def second_anagram?(str1, str2)
  str1_copy = str1.dup
  str2_copy = str2.dup

  str1_copy.each_char do |char|
    if str2.include?(char)
      str1.slice!(char)
      str2.slice!(char)
    end
  end

  str1.empty? && str2.empty?
end

def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end

def fourth_anagram?(str1, str2)
  hsh = Hash.new(0)
  str1.each_char do |char|
    hsh[char] += 1
  end

  str2.each_char do |char2|
    hsh[char2] -= 1
  end

  hsh.values.all? { |el| el == 0 }
end
