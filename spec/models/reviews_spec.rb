require File.dirname(__FILE__) + '/../spec_helper'

describe Reviews do
  before(:each) do
    @reviews = Reviews.new
  end

  it "should be valid" do
    @reviews.should be_valid
  end
end
