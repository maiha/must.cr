require "./spec_helper"
require "json"

describe "Must#match" do
  it "Nil" do
    nil.must.match(/^$/).should eq(nil)

    match_error nil.must.match(/foo/)
  end

  it "String" do
    "123:count:456".must.match(/\d+/).should eq("123:count:456")
    "123:count:456".must.match(/\d+/, "OK").should eq("OK")
    "123:count:456".must.match(/(\d+)/, "c=$1").should eq("c=123")
    "123:count:456".must.match(/count:(\d+)/, "c=$1").should eq("c=456")

    match_error "aaa".must.match(/foo/)
  end
end
