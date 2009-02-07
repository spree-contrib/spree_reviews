require File.dirname(__FILE__) + '/../spec_helper'

describe Ratings do
  before(:each) do
    @ratings = Ratings.new
  end

  it "should be valid" do
    @ratings.should be_valid
  end
end
