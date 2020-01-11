module Must
  class Error < Exception
  end

  class CastError < Error
  end

  class TypeError < Error
  end

  class MatchError < Error
  end

  def self.cast_error(value, to)
    msg = "cast from %s to %s failed. (value=%s)" % [value.class, to, value]
    raise CastError.new(msg)
  end

  def self.type_error(value, expected_klass)
    msg = "expected %s, but got %s (%s)" % [expected_klass, value.class, value]
    raise TypeError.new(msg)
  end
end
