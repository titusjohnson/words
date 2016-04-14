class Parser
  def initialize(dictionary)
    @dictionary = dictionary
    @breakdown  = {}
    @blacklist  = []
  end

  # 
  # Iterate a given array of words and identify unique alphabetic
  # sequences of letters. Load these sequences into a hash for
  # future use, and sort alphabetically by key.
  # 
  # @return [Self]
  def parse
    @dictionary.each do |word|
      word_sequences = subsequence_word(word)

      word_sequences.each do |sequence|
        # If we want to normalize case
        # sequence = sequence.downcase
        next if @blacklist.include? sequence
        
        if @breakdown.key? sequence
          @blacklist << sequence
          @breakdown.delete sequence
        else
          @breakdown[sequence] = word
        end
      end

      print_progress
    end

    puts '.'

    @breakdown = Hash[@breakdown.sort_by{ |k,v| k }]

    self
  end

  # 
  # Returns all unique sequences in alphabetic order
  # 
  # @return [Array]
  def sequences
    @breakdown.keys
  end

  # 
  # Return all words in order ordered by their sequences
  # 
  # @return [Array]
  def words
    @breakdown.values
  end

  # 
  # When given a word, return an array of all 4-character
  # alphabetic sequences included in the word
  #  
  # @param word [String] a word of some kind
  # 
  # @return [Array] an Array of 4 character sequences
  def subsequence_word(word)
    sequence_start = 0
    sequence_end   = 3
    word_sequences = []

    while sequence_end < word.length do
      sequence = word[sequence_start..sequence_end]
      word_sequences << sequence if is_usable? sequence
      
      sequence_start += 1
      sequence_end   += 1
    end

    word_sequences
  end

  # 
  # Checks if a given sequence contains only alphabetic characters
  # 
  # @param sequence [String] of characters
  # 
  # @return [Boolean]
  def is_usable?(sequence)
    !/[^a-zA-Z]/.match sequence
  end

  # 
  # Progress indicators make things look like they haven't broken
  def print_progress
    print '.'
    $stdout.flush
  end
end
