require "./spec_helper"
require "json"

describe "Must#any" do
  it "(not empty) returns self" do
    0  .must.any.should eq(0)
    1  .must.any.should eq(1)
    "a".must.any.should eq("a")
    [0].must.any.should eq([0])
  end

  it "(empty) raises Must::Error" do
    must_error nil.must.any
    must_error "".must.any
    must_error Array(Int32).new.must.any
  end
end

describe "Must#any?" do
  it "(not empty) returns true" do
    0  .must.any?.should eq(true)
    1  .must.any?.should eq(true)
    "a".must.any?.should eq(true)
    [0].must.any?.should eq(true)
  end

  it "(empty) returns false" do
    nil.must.any?.should eq(false)
    "" .must.any?.should eq(false)
    Array(Int32).new.must.any?.should eq(false)
  end
end
