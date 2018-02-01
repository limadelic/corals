require 'spec_helper'
require 'corals/dominoes'

describe 'Dominoes' do

  describe 'Game' do

    subject { resolve rules: [:dominoes] }

    it 'has a table' do
      expect(subject).to have_key :table
    end

    it '4 players' do
      expect(subject[:players].count).to be 4
    end

    it 'has 55 dominoes' do
      expect(subject[:dominoes].count).to be 55
    end

  end

  describe 'Start' do

    subject { resolve on: :start, rules: [:dominoes] }

    it 'table is empty' do
      expect(subject[:table]).to be_empty
    end

    it 'each player with 10 dominoes' do
      subject[:players].each do |_, dominoes|
        expect(dominoes).to be 10
      end
    end

  end

end