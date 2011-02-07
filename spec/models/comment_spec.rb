require 'spec_helper'

describe Comment do

  before(:each) do
    @user = Factory(:user)
    @post = @user.posts.create!(:title => "fooTitle",
                                :content => "fooContent")
    @attr = { 
      :content => "this is a comment",
      :post => @post
    }
  end

  it "should create a new comment given valid attributes" do
    @user.comments.create!(@attr)
  end

  describe "user and post associations" do

    before(:each) do
      @comment = @user.comments.create(@attr)
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have a post attribute" do
      @comment.should respond_to(:post)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user
    end

    it "should have the right associated post" do
      @comment.post_id.should == @post.id
      @comment.post.should == @post
    end
  end
end
