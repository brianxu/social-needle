require 'spec_helper'

describe Comment do

  before(:each) do
    @user = Factory(:user)
    @post = @user.posts.create!(:title => "fooTitle",
                                :content => "fooContent")
    @attr = { 
      :content => "this is a comment",
      :post_id => @post.id
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

  describe "validations" do

    it "should require a user id" do
      Comment.new(@attr).should_not be_valid
    end

    it "should require a post id" do
      @user.comments.build(:content => "foo").should_not be_valid
    end

    it "should require nonblank content" do
      @user.comments.build(:content => " ").should_not be_valid
    end
  end

  describe "POST 'create'" do

    describe "failure" do
      
      before(:each) do
        @attr = { :content => "" }
      end

      #it "should not create a comment" do
        #lambda do
          #post :create, :comment => @attr
        #end.should_not change(Comment, :count)
      #end

      #######
      # TODO
      #
      # #####
      
    end
  end
end
