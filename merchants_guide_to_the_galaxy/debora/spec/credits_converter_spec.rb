require 'spec_helper'
require_relative '../app/credits_converter'

RSpec.describe 'CreditsConverter' do
  subject { CreditsConverter.new } 

  before(:each) do
    subject.add_to_roman_conversion_table('glob', 'I')
    subject.add_to_roman_conversion_table('prok','V')
    subject.add_to_roman_conversion_table('pish','X')
    subject.add_to_roman_conversion_table('tegj','L')
    subject.add_to_credits_conversion_table(%w(glob glob Silver), 34)
    subject.add_to_credits_conversion_table(%w(glob prok Gold), 57800)
    subject.add_to_credits_conversion_table(%w(pish pish Iron), 3910)
  end

  it 'should have the right roman convertion table' do
    correct_table = { 'glob' => 'I', 'prok' => 'V', 'pish' => 'X', 'tegj' => 'L'}
    expect(subject.roman_conversion_table).to eq(correct_table)
  end

  it 'shoud have the right credits conversion table' do
    correct_table = { 'Silver' => 17.0, 'Gold' => 14450.0, 'Iron' => 195.5 }
    expect(subject.credits_conversion_table).to eq(correct_table)
  end

  it 'should convert the value correctly' do
    expect(subject.convert_to_number(%w(pish tegj glob glob))).to eq(42.0)
  end

  it 'should calculate the credits correctly' do
    expect(subject.convert_to_credits(%w(glob prok Silver))).to eq(68.0)
    expect(subject.convert_to_credits(%w(glob prok Gold))).to eq(57800.0)
    expect(subject.convert_to_credits(%w(glob prok Iron))).to eq(782.0)
  end
end