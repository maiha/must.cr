module Must::Match
  def match(value : T, regex : Regex) : T forall T
    case value.to_s
    when regex
      return value
    else
      raise Must::MatchError.new("doesn't match /#{regex.source}/")
    end
  end

  def match(value, regex : Regex, fmt : String) : String
    if md = regex.match(value.to_s)
      replacements = Hash(Int32, String).new
      md.captures.each_with_index do |v, i|
        replacements[i+1] = v.to_s
      end
      return fmt.gsub(/\$(\d+)/) { replacements[$1.to_i]?.to_s }
    else
      raise Must::MatchError.new("doesn't match /#{regex.source}/")
    end
  end

  extend self
end
