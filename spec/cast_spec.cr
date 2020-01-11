require "./spec_helper"

describe "Must#cast" do
  it "atomic types" do
    1.must.cast(Int64).should be_a(Int64)
    1.must.cast(String).should eq("1")
  end

  it "to Float32" do
    1.must.cast(Float32).should eq(1.0)
    1.0_f32.must.cast(Float32).should eq(1.0)
    1.0_f64.must.cast(Float32).should eq(1.0)
    "1".must.cast(Float32).should eq(1.0)
    "1.0".must.cast(Float32).should eq(1.0)

    typeof(1.must.cast(Float32)).should eq(Float32)
  end

  it "to Float64" do
    1.must.cast(Float64).should eq(1.0)
    1.0_f32.must.cast(Float64).should eq(1.0)
    1.0_f64.must.cast(Float64).should eq(1.0)
    "1".must.cast(Float64).should eq(1.0)
    "1.0".must.cast(Float64).should eq(1.0)

    typeof(1.must.cast(Float64)).should eq(Float64)
  end
  
  it "Array(Int64)" do
    v = [1_i64.as(TOML::Type)].as(Array(TOML::Type))
    v.must.cast(Array(Int64)).should eq([1])

    cast_error v.must.cast(Array(Bool))
    cast_error v.must.cast(Int64)
    cast_error v.must.cast(Nil)
  end

  it "Hash(String, Int64)" do
    v = {"a" => 1_i64.as(TOML::Type)}.as(TOML::Table)
    v.must.cast(Hash(String, Int64)).should eq({"a" => 1_i64})

    cast_error v.must.cast(Hash(String, Bool))
    cast_error v.must.cast(Array(Bool))
    cast_error v.must.cast(Int64)
    cast_error v.must.cast(Nil)
  end

  it "Hash(String, Hash(String, Int64))" do
    v = {"a" => {"b" => 1_i64.as(TOML::Type)}}.as(Hash(String, TOML::Table))
    v.must.cast(Hash(String, TOML::Type))
  end
end
