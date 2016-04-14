require_relative '../../lib/parser'

RSpec.describe Parser do
  context 'parsing word sequences per the instructional example' do
    it 'spits out the proper sequences given the test dictionary' do
      parser = Parser.new(%w(arrows carrots give me))

      parser.parse

      expect(parser.sequences).to eq %w(carr give rots rows rrot rrow)
    end

    it 'spits out words in the proper sequences given the test dictionary' do
      parser = Parser.new(%w(arrows carrots give me))

      parser.parse

      expect(parser.words).to eq %w(carrots give carrots arrows carrots arrows)
    end

    it 'does not include dupes in the sequence list' do
      parser = Parser.new(%w(arrows carrots give me))

      parser.parse

      expect(parser.sequences).to_not include('arro')
    end
  end

  describe 'getting word sequences with .subsequence_word' do
    it 'returns an array containing all subsections 4 characters long' do
      parser = Parser.new([])
      expect(parser.subsequence_word('1stest')).to eq %w(stes test)
      expect(parser.subsequence_word('1st')).to eq []
      expect(parser.subsequence_word('bob')).to eq []
      expect(parser.subsequence_word('bobs')).to eq %w(bobs)
      expect(parser.subsequence_word('bobsa')).to eq %w(bobs obsa)
      expect(parser.subsequence_word('bobsan')).to eq %w(bobs obsa bsan)
    end
  end

  describe 'blacklisting special characters with .is_usable?' do
    it 'returns false if the string given contains non alphabetic characters' do
      parser = Parser.new([])
      expect(parser.is_usable?('1234')).to be false
      expect(parser.is_usable?('abc&')).to be false
      expect(parser.is_usable?('abc!')).to be false
      expect(parser.is_usable?('a2bcsdf')).to be false
      expect(parser.is_usable?('ab cd')).to be false
      expect(parser.is_usable?("ab\ncd")).to be false
      expect(parser.is_usable?("ab\tcd")).to be false
    end

    it 'returns true if only alphabetic characters are submitted' do
      parser = Parser.new([])
      expect(parser.is_usable? 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ').to be true
    end
  end
end
