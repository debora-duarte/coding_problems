class RomanConverter
  @@roman_digits_table = {  'I' => 1, 
                            'V' => 5, 
                            'X' => 10, 
                            'L' => 50, 
                            'C' => 100, 
                            'D' => 500, 
                            'M' =>1000 }

  def self.convert(roman_numeral)
    raise InvalidSyntaxError if invalid?(roman_numeral)
    calculate(roman_numeral)
  end

  def self.invalid?(roman_numeral)
    invalid_chars?(roman_numeral) || invalid_groups?(roman_numeral) || any_invalid_pair?(roman_numeral)
  end

  def self.invalid_chars?(roman_numeral)
    roman_numeral.each_char.detect { |c| !@@roman_digits_table.keys.include?(c) }
  end

  def self.invalid_groups?(roman_numeral)
    roman_numeral.match(/(IIII|XXXX|CCCC|MMMM|VV|LL|DD)/)
  end

  def self.any_invalid_pair?(roman_numeral)
    roman_numeral.each_char.each_cons(2).detect do |a|
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

  def self.calculate(roman_numeral)
    value = roman_numeral.each_char.each_cons(2).inject(0) do |sum, a|
      if crescent_pair?(a[0], a[1])
        sum -= @@roman_digits_table[a[0]]
      else
        sum += @@roman_digits_table[a[0]]
      end
    end
    value += @@roman_digits_table[roman_numeral[-1]]      
  end
end