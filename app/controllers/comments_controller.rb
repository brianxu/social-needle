class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destory]

  def new
    @comment = @post.comments.new
  end

  def create
    
    @comment = current_user.comments.build(params[:comment])
    @comment.post_id = params[:post_id]
    #@comment.post_id = "301"

    if @comment.save
      flash[:success] = "Comments create."
      redirect_to post_path(params[:post_id])
    else
      flash[:failure] = "Failed to create comments."
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
  end

end
