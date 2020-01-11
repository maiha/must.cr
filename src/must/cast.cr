module Must::Cast
  # OK: Nil to Nil
  def cast(value, klass : Nil.class)
    case value
    when nil   ; nil
    else       ; Must.cast_error(value, klass)
    end
  end

  # OK: Array to Array
  def cast(value : Array, klass : Array(U).class) : Array(U) forall U
    array = Array(U).new
    value.as(Array).each do |v|
      array << cast(v, U)
    end
    return array
  end

  # OK: Hash to Hash
  def cast(value, klass : Hash(U, V).class) : Hash(U, V) forall U, V
    hash = Hash(U, V).new
    if value.is_a?(Hash)
      value.as(Hash).each do |k,v|
        hash[cast(k, U)] = cast(v, V)
      end
    else
      # otherwise, check value is a Hash for the case of Union Types
      Must.cast_error(value, klass)
    end
    return hash
  end

  def cast(value, klass : Int32.class) : Int32
    case value
    when Int32 ; value.as(Int32)
    when Int64 ; value.to_i32
    when String; value.to_i32(strict: false)
    else       ; Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : Int64.class) : Int64
    case value
    when Int32 ; value.as(Int32).to_i64
    when Int64 ; value.to_i64
    when String; value.to_i64(strict: false)
    else       ; Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : Float32.class) : Float32
    case value
    when Float32; value
    when Float64; value.to_f32
    when Int32  ; value.as(Int32).to_f32
    when Int64  ; value.to_f32
    when String ; value.to_f32(strict: false)
    else        ; Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : Float64.class) : Float64
    case value
    when Float32; value.to_f64
    when Float64; value
    when Int32  ; value.as(Int32).to_f64
    when Int64  ; value.to_f64
    when String ; value.to_f64(strict: false)
    else        ; Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : String.class)
    value.to_s
  end

  def cast(value, klass : Enum.class)
    case value
    when Int32 ; klass.from_value(value.as(Int32).to_i64)
    when Int64 ; klass.from_value(value.to_i64)
    when Enum  ; value
    else       ; Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : Time::Span.class)
    case value.to_s
    when ""
      return nil
    when /^(\d{2}):(\d{2}):(\d{2})/
      Time::Span.new($1.to_i, $2.to_i, $3.to_i)
    else
      Must.cast_error(value, klass)
    end
  end

  def cast(value, klass : Time.class)
    case value
    when Time
      return value
    else
      Must.cast_error(value, klass)
    end
  end

  # otherwise
  def cast(value, klass : T.class) forall T
    if value.is_a?(T)
      # cast from Hash(String, TOML::Type) to TOML::Type
      value.as(T)
    else
      # otherwise
      Must.cast_error(value, T)
    end
  end

  extend self
end
