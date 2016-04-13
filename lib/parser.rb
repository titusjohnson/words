class Parser
  attr_accessor :dictionary, :breakdown, :blacklist

  def initialize(dictionary)
    @dictionary = dictionary
    @breakdown = {}
    @blacklist = []
  end

  def parse
    dictionary.each do |word|
      word_sequences = subsequence_word(word)

      word_sequences.each do |seq|
        next if blacklist.include?(seq)
        
        if breakdown.key? seq
          blacklist << seq
          breakdown.delete seq
        else
          breakdown[seq] = word
        end
      end
    end
  end

  def sequences
    Hash[breakdown.sort_by{ |k,v| k }].keys
  end

  def words
    Hash[breakdown.sort_by{ |k,v| k }].values
  end

  def subsequence_word(word)
    sequence_start = 0
    sequence_end = 3
    word_sequences = []

    while sequence_end < word.length do
      word_sequences << word[sequence_start..sequence_end]
      sequence_start += 1
      sequence_end += 1
    end

    word_sequences
  end
end
