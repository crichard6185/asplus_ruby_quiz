class Consecutive
  attr_reader :string
  
  def initialize(string)
    @string = string
  end
  
  def max_consecutive_characters
    repeated = string.scan(/((\w)\2+)/)

    counts = {}

    repeated.each do |match,letter|
      counts[match.length] ||= []
      counts[match.length] << letter
    end

    highest_key = counts.keys.max

    counts[highest_key].uniq.sort
  end
end
