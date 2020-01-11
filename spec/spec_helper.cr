require "json"
require "spec"
require "../src/must"

module TOML
  alias Type = Bool | Int64 | Float64 | String | Time | Array(Type) | Hash(String, Type)
  alias Table = Hash(String, Type)
end

macro cast_error(expr)
  expect_raises(Must::CastError) do
    {{expr}}
  end
end

macro type_error(expr)
  expect_raises(Must::TypeError) do
    {{expr}}
  end
end

macro match_error(expr)
  expect_raises(Must::MatchError) do
    {{expr}}
  end
end
