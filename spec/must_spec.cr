require "./spec_helper"
require "json"

describe "Object#must" do
  it "Nil" do
    nil.must(Nil).should eq(nil)

    type_error nil.must(Int32)
    type_error nil.must(Hash(String, String))
  end

  it "Array" do
    [1].must(Array(Int32)).should eq([1])

    type_error [1].must(Array(String))
  end
end
