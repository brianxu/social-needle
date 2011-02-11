class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destory]

  def create
    @comment = current_user.comments.build!(:content => params[:comment][:content],
                                            :post_id = @post.id)
    if @comment.save
      flash[:success] = "Comments create."
      redirect_to post_path(@post)
    else
      flash[:failure] = "Failed to create comments."
      redirect_to post_path(@post)
    end
  end

  def destroy
  end

end
