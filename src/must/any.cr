module Must::Any
#  def any?(value : T) : Bool
#
#  end

  def any?(value : Nil) : Bool
    false
  end

  def any?(value) : Bool
    if value.responds_to?(:empty?)
      return ! value.empty?
    else
      return true
    end
  end

  def any(value : T, name : String? = nil) : T forall T
    if any?(value)
      return value
    else
      name ||= "(value)"
      raise Must::Error.new("#{name} is empty")
    end
  end

  extend self
end
