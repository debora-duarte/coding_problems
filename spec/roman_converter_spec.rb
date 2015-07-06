require 'spec_helper'
require_relative '../app/roman_converter'
require_relative '../app/invalid_syntax_error'

RSpec.describe 'RomanConverter' do

  describe 'Syntax Errors' do
    it 'should raise invalid syntax when I repeat IIII four times' do
      expect { RomanConverter.convert('IIII'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat XXXX four times' do
      expect { RomanConverter.convert('XXXX'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat CCCC four times' do
      expect { RomanConverter.convert('CCCC'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat MMMM four times' do
      expect { RomanConverter.convert('MMMM'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat DD two times' do
      expect { RomanConverter.convert('DD'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat LL two times' do
      expect { RomanConverter.convert('LL'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I repeat VV two times' do
      expect { RomanConverter.convert('VV'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I pass IL' do
      expect { RomanConverter.convert('IL'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I pass IC' do
      expect { RomanConverter.convert('IC'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I pass ID' do
      expect { RomanConverter.convert('ID'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax when I pass XD' do
      expect { RomanConverter.convert('XD'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax  when I pass XM' do
      expect { RomanConverter.convert('XM'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax  when I pass VX' do
      expect { RomanConverter.convert('VX'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax  when I pass LC' do
      expect { RomanConverter.convert('LC'.chars) }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax  when I pass VX' do
      expect { RomanConverter.convert('DM'.chars) }.to raise_error(InvalidSyntaxError)
    end
  end

  it 'should return 1435 when I pass MCDXXXV' do
    expect(RomanConverter.convert('MCDXXXV'.chars)).to eq(1435)
  end
end