require 'spec_helper'

describe Micropost do

  before(:each) do
    @user = Factory(:user)
    @attr = {
      :title => "this is title",
      :content => "this is content"
    }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associatons" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank title" do
      @user.microposts.build(:title => " ").should_not be_valid
    end

    it "should reject long title" do
      @user.microposts.build(:title => "a" * 141).should_not be_valid
    end
  end
end
