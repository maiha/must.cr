require "./spec_helper"

describe "(readme)" do
  it "works" do
    1.must(Int32).should eq(1)
    type_error 1.must(String)

    1.must.cast(String).should eq("1")
    cast_error 1.must.cast(Bool)

    708.must.match(/0/).should eq(708)
    708.must.match(/0(.)/, "$1").should eq("8")

    json = JSON.parse(%|{"a": 1}|)
    json["a"].raw.must.cast(Float64).should eq(1.0)
    typeof(json["a"].raw.must.cast(Float64)).should eq(Float64)
  end

  pending "must vs as" do
    hash = {"i1" => 1, "s1" => "foo", "i2" => 2}
    typeof(hash).should eq(Hash(String, Int32 | String))

    hash1 = hash.grep(/^i/)
    hash1.should eq({"i1" => 1, "i2" => 2})
    typeof(hash1).should eq(Hash(String, Int32 | String))

    hash2 = hash1.must.cast(Hash(String, Int32))
    hash2.should eq({"i1" => 1, "i2" => 2})
    typeof(hash2).should eq(Hash(String, Int32))

    hash3 = hash1.must.cast(Hash(String, Bool))
    hash4 = hash1.as(Hash(String, Bool))
  end
end
