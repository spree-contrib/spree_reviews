require File.dirname(__FILE__) + '/../spec_helper'

describe ReviewsController do

  #Delete these examples and add some real ones
  it "should use ReviewsController" do
    controller.should be_an_instance_of(ReviewsController)
  end


  it "GET 'submit' should be successful" do
    get 'submit'
    response.should be_success
  end
end
