class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @post
    else 
      redirect_to @post
      # render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
