class CommentsController < ApplicationController
  protect_from_forgery except: [:create, :destroy]
  before_action :logged_in_user

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @post
    else
      flash[:danger] = "Comment should not be empty or too long (up to 140 characters)."
      redirect_to post_url(@post, comment_content: params[:comment][:content])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
