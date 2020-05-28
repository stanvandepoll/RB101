ADJECTIVES = %w(quick lazy sleepy ugly).freeze
NOUNS      = %w(fox dog head leg cat tail).freeze
VERBS      = %w(spins bites licks hurdles).freeze
ADVERBS    = %w(easily lazily noisly excitedly).freeze

text = File.read('madlibs.txt')
text.split("\n").each do |line|
  line.gsub!('%{adjective}', ADJECTIVES.sample)
  line.gsub!('%{noun}', NOUNS.sample)
  line.gsub!('%{adverb}', ADVERBS.sample)
  line.gsub!('%{verb}', VERBS.sample)
  puts line
end
