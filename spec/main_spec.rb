require 'spec_helper'
require_relative '../app/main'

RSpec.describe 'Main' do

  subject{ Main.new } 

  before(:each) do
    subject.input('glob is I')
    subject.input('prok is V')
    subject.input('pish is X')
    subject.input('tegj is L')
    subject.input('glob glob Silver is 34 Credits')
    subject.input('glob prok Gold is 57800 Credits')
    subject.input('pish pish Iron is 3910 Credits')
  end

  describe 'Syntax errors' do
    it 'should raise invalid syntax error' do
      expect{ subject.input('prok pish Silver is 34 Credits') }.to raise_error(InvalidSyntaxError)
    end

    it 'should raise invalid syntax error' do
      expect{ subject.input('how many Credits is glob prok Copper ?') }.to raise_error(InvalidSyntaxError)
    end  

    it 'should answer I have no idea what you are talking about' do
      expect(subject.input('glob is A')).to eq('I have no idea what you are talking about')
    end
  end

  it 'should answer corretly how much is pish tegj glob glob' do
    expect(subject.input('how much is pish tegj glob glob ?')).to eq('pish tegj glob glob is 42')
  end

  it 'should answer corretly how many credits is glob prok Silver' do
    expect(subject.input('how many Credits is glob prok Silver ?')).to eq('glob prok Silver is 68 Credits')
  end

  it 'should answer corretly how many credits is glob prok Gold' do
    expect(subject.input('how many Credits is glob prok Gold ?')).to eq('glob prok Gold is 57800 Credits')
  end

  it 'should answer corretly how many credits is glob prok Iron' do
    expect(subject.input('how many Credits is glob prok Iron ?')).to eq('glob prok Iron is 782 Credits')
  end

  it 'should answer I have no idea what you are talking about' do
    expect(
      subject.input('how much wood could a woodchuck chuck if a woodchuck could chuck wood ?')
    ).to eq('I have no idea what you are talking about')
  end 
end