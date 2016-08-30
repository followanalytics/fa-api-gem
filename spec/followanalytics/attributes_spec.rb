require 'spec_helper'

describe Followanalytics::Attributes::Client do
  describe 'predefined attributes' do
    it 'defines a method for each predefined attributes' do
      methods = described_class::PREDEFINED_ATTRIBUTE_KEYS.map { |k| "set_#{k}".to_sym }
      client = described_class.new('a-random-sor')
      expect(client.methods).to include(*methods)
    end
  end

  describe 'set_value' do
  end

  describe 'unset_value' do
  end

  describe 'add_set_value' do
  end

  describe 'remove_set_value' do
  end
end
