class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destory]

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comments create."
      #should redirect to post page
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

end
