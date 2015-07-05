class RomanConverter
  @@roman_digits_table = {  'I' => 1, 
                            'V' => 5, 
                            'X' => 10, 
                            'L' => 50, 
                            'C' => 100, 
                            'D' => 500, 
                            'M' =>1000 }

  def self.convert(roman_number)
    raise InvalidSyntaxError if invalid?(roman_number)
    calculate(roman_number)
  end

  def self.invalid?(roman_number)
    invalid_groups?(roman_number) || any_invalid_pair?(roman_number)
  end

  def self.invalid_groups?(roman_number)
    roman_number.match(/(IIII|XXXX|CCCC|MMMM|VV|LL|DD)/)
  end

  def self.any_invalid_pair?(roman_number)
    roman_number.each_char.each_cons(2).detect do |a|
       invalid_pair?(a[0], a[1])        
    end
  end

  def self.invalid_pair?(d1, d2)
    permitted_crescent_pairs = ['IV', 'IX', 'XL', 'XC', 'CD', 'CM']
    crescent_pair?(d1, d2) && !permitted_crescent_pairs.include?(d1 + d2)
  end

  def self.crescent_pair?(i1, i2)
    @@roman_digits_table[i2] > @@roman_digits_table[i1]
  end

  def self.calculate(roman_number)
    value = roman_number.each_char.each_cons(2).inject(0) do |sum, a|
      if crescent_pair?(a[0], a[1])
        #require 'byebug'; byebug  
        sum -= @@roman_digits_table[a[0]]
      else
        sum += @@roman_digits_table[a[0]]
      end
    end
    value += @@roman_digits_table[roman_number[-1]]      
  end
end