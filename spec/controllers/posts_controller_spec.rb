require 'spec_helper'

describe PostsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destory'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :content => "" }
      end

      it "should not create a post" do
        lambda do
          post :create, :post => @attr
        end.should_not change(Post, :count)
      end

      it "should render the home page" do
        post :create, :post => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "fooTitle", :content => "fooContent" }
      end

      it "should create a post" do
        lambda do
          post :create, :post => @attr
        end.should change(Post, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :post => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :post => @attr
        flash[:success].should =~ /post created/i
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @post = @user.posts.create!(:title => "foo",
                                  :content => "bar")
    end

    it "should be successful" do
      get :show, :id => @post
      response.should be_success
    end

    it "should find the right post" do
      get :show, :id => @post
      assigns(:post).should == @post
    end

    it "should have the right title" do
      get :show, :id => @post
      response.should have_selector("title", :content => @post.title)
    end

    it "should include the user's name" do
      get :show, :id => @post
      response.should have_selector("h3", :content => @user.name)
    end

    it "should show the details of the post" do
      get :show, :id => @post
      response.should have_selector("td.post span.title", :content => @post.title)
      response.should have_selector("td.post span.content", :content => @post.content)
    end
  end

  describe "Add comment to post" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @post = @user.posts.create!(:title => "foo",
                                  :content => "bar")
      @comment = @user.comments.create!(:content => "comment",
                                        :post_id => @post.id)
    end

    it "should show the details of the comment" do
      get :show, :id => @post
      response.should have_selector("td.comment span.content",
                                    :content => @comment.content)
    end
  end

end

