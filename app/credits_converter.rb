require_relative 'roman_converter'

class CreditsConverter
  def initialize
    @roman_conversion_table = {}
    @credits_conversion_table = {}
  end

  attr_reader :roman_conversion_table, :credits_conversion_table

  def add_to_roman_conversion_table(word, roman_numeral)
    roman_conversion_table[word] = roman_numeral
  end

  def add_to_credits_conversion_table(words, number)
    credit_words = find_credit_words(words)
    words = find_words(words)
    roman_numerals = convert_words_to_roman_numerals(words)
    conversion_roman_numeral = RomanConverter.convert(roman_numerals)
    credits_conversion_table[credit_words] = number.to_f / conversion_roman_numeral    
  end

  def find_credit_words(words)
    words.detect { |word| !roman_conversion_table.include?(word) }
  end

  def find_words(words)
    words.select { |word| roman_conversion_table.include?(word) }
  end

  def convert_words_to_roman_numerals(words)
    find_words(words).map { |word| roman_conversion_table[word] }
  end

  def convert_to_number(words)
    roman_numerals = convert_words_to_roman_numerals(words)
    RomanConverter.convert(roman_numerals)
  end

  def convert_to_credits(words)
    require 'byebug'; byebug
    number = convert_to_number(words)
    credit_word = find_credit_words(words)
    number * credits_conversion_table[credit_word]
  end
end