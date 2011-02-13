class PostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.title
    @user = @post.user
    @comments = @post.comments.paginate(:page => params[:page])
    render "shared/posts/_show"
  end

  def destroy
  end
end

