require 'spec_helper'
require 'integertomaya'

class Test
  include IntegerToMaya
end

describe IntegerToMaya do
  subject { Test.new }

  describe '#convert' do
    it 'should convert numbers over or equal to 1 and under 5' do
      result = subject.integer_to_maya("4")
      expect(result).to eq("oooo")
    end

    it 'should convert numbers over or equal to 5 and under 20' do
      result = subject.integer_to_maya("13")
      expect(result).to eq("ooo\n-----\n-----")
    end

    it 'should convert numbers over or equal to 20 and under 400' do
      result = subject.integer_to_maya("283")
      expect(result).to eq("oooo\n-----\n-----\n\nooo")
    end

    it 'should convert 0 to <(((>' do
      result = subject.integer_to_maya("400")
      expect(result).to eq("o\n\n<(((>\n\n<(((>")
    end

    it 'should convert numbers over or equal to 400' do
      result = subject.integer_to_maya("689")
      expect(result).to eq("o\n\noooo\n-----\n-----\n\noooo\n-----")
    end

    it 'should convert numbers with a floor with only a bar' do
      result = subject.integer_to_maya("405")
      expect(result).to eq("o\n\n<(((>\n\n-----")
    end
  end

  describe '#verfify' do
    it 'should raise an error if the input number has non-digit characters or is empty' do
      expect{subject.integer_to_maya("B")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_maya("/")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_maya(".")}.to raise_error("only digit characters are allowed")
      expect{subject.integer_to_maya("")}.to raise_error("only digit characters are allowed")
    end
  end
end
