require_relative 'lib/parser'

puts 'opening file'
file = File.open('data/dictionary.txt') or die 'File died'
dictionary = IO.foreach(file).map { |l| l.strip }
file.close

puts 'parsing file'
parser = Parser.new(dictionary).parse

puts "Sequence count: #{parser.sequences.count}"
puts "Word count: #{parser.words.count}"

open('sequences', 'w') { |f| f.puts parser.sequences.join("\n") }
puts 'sequence file written'

open('words', 'w') { |f| f.puts parser.words.join("\n") }
puts 'words file written'

puts 'All done. Get your files at ./'
