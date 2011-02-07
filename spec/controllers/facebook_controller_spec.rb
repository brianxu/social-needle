require 'spec_helper'

describe FacebookController do
  render_views

  describe "GET 'connect'" do
    it "should be successful" do
      get 'connect'
      response.should be_success
    end
  end

end
