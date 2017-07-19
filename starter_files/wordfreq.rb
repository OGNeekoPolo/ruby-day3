require "pry"
class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @contents = File.read(filename).downcase
    @contents.gsub!(/[^a-z0-9]/, ' ')
    STOP_WORDS.each do |word|
      @contents.gsub!(/\b(?:#{word})\b/, ' ')
    end
    @contents
  end

  def frequency(word)
    #look up .scan and .count
    counter = @contents.scan(/\b(?:#{word})\b/).count
  end

  def frequencies
    hash = Hash.new
    array = @contents.split(" ")
    array.each do |word|
      hash[word] = frequency(word)
    end
    hash
  end

  def top_words(number)
    top = frequencies.sort_by{|word, count| count}.reverse
    top.take(number)
  end

  def print_report
    top_words(10).each do |key, value|
      puts "#{key} | #{value} " + "*"* value
    end
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end

binding.pry
