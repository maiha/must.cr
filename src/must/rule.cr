struct Must::Rule(T)
  def initialize(@value : T)
  end

  def be_a(klass : Class) : T
    if @value.class == klass
      return @value
    else
      raise ::Must.type_error(@value, klass)
    end
  end

  def any : T
    ::Must::Any.any(@value)
  end

  def any? : Bool
    ::Must::Any.any?(@value)
  end

  def cast(klass : U.class) : U forall U
    ::Must::Cast.cast(@value, U)
  end

  def match(regex : Regex) : T
    ::Must::Match.match(@value, regex)
    return @value
  end

  def match(regex : Regex, fmt : String) : String
    ::Must::Match.match(@value, regex, fmt: fmt)
  end
end
