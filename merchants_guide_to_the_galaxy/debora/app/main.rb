require_relative 'credits_converter'
require_relative 'invalid_syntax_error'

class Main
  def initialize
    @credits_converter = CreditsConverter.new
  end

  attr_accessor :credits_converter

  def input(sentence)
    case sentence
    when /.+\s+is\s+(I|V|X|L|C|D|M)/ # Ex: glob is I
      store_roman_conversion_data(sentence)
    when /.+is\s+\d+\s+Credits/ # Ex: glob glob Silver is 34 Credits
      store_credits_conversion_data(sentence)
    when /\Ahow much is/i # Ex: how much is pish tegj glob glob ?
      answer_value_question(sentence) 
    when /\Ahow many credits is/i # Ex: how many Credits is glob prok Gold ?
      answer_credits_question(sentence)
    else
      'I have no idea what you are talking about'
    end
  end

  def store_roman_conversion_data(sentence)
    word = sentence.split[0]
    roman_numeral = sentence.split[2]
    credits_converter.add_to_roman_conversion_table(word, roman_numeral)
  end

  def store_credits_conversion_data(sentence)
    words = sentence.split[0..-4]
    number = sentence[/\d+/]
    credits_converter.add_to_credits_conversion_table(words, number)
  end

  def answer_value_question(sentence)
    value_demanded = value_demanded(sentence)
    answer = credits_converter.convert_to_number(value_demanded.split)
    "#{value_demanded} is #{answer.to_i}" # Ex: pish tegj glob glob is 42
  end

  def answer_credits_question(sentence)
    value_demanded = value_demanded(sentence)
    answer = credits_converter.convert_to_credits(value_demanded.split)
    "#{value_demanded} is #{answer.to_i} Credits" # Ex: glob prok Silver is 68 Credits
  end

  def value_demanded(sentence)
    sentence.partition(/is/i)[-1].gsub('?','').strip
  end
end
