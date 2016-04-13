require_relative '../../lib/parser'

RSpec.describe Parser do
  describe 'parsing word sequences' do
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

  describe 'split a word into sequences' do
    it 'returns an array containing all subsections 4 characters long' do
      parser = Parser.new([])
      expect(parser.subsequence_word('bob')).to eq []
      expect(parser.subsequence_word('bobs')).to eq %w(bobs)
      expect(parser.subsequence_word('bobsa')).to eq %w(bobs obsa)
      expect(parser.subsequence_word('bobsan')).to eq %w(bobs obsa bsan)
    end
  end
end
