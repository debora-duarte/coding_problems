require_relative 'credits_converter'
require_relative 'invalid_syntax_error'

class Main
  def initialize
    @credits_converter = CreditsConverter.new
  end

  attr_accessor :credits_converter

  def input(sentence)
    case sentence
    when /.+\s+is\s+(I|V|X|L|C|D|M)/
      store_roman_conversion_data(sentence)
    when /.+is\s+\d+\s+Credits/
      store_credits_conversion_data(sentence)
    when /\Ahow much is/i
      answer_value_question(sentence) 
    when /\Ahow many credits is/i
      answer_credits_question(sentence)
    else
      'I have no idea what you are talking about'
    end
  end

  def store_roman_conversion_data(i)
    credits_converter.add_to_roman_conversion_table(i.split[0], i.split[2])
  end

  def store_credits_conversion_data(i)
    credits_converter.add_to_credits_conversion_table(i.split[0..-4], i[/\d+/])
  end

  def answer_value_question(i)
    value_asked = i.partition(/is/i)[-1].gsub('?','').strip
    answer = credits_converter.convert_to_number(value_asked.split)
    "#{value_asked} is #{answer.to_i}"
  end

  def answer_credits_question(i)
    value_asked = i.partition(/is/i)[-1].gsub('?','').strip
    answer = credits_converter.convert_to_credits(i.partition(/is/i)[-1].gsub('?','').split)
    "#{value_asked} is #{answer.to_i} Credits"
  end
end
