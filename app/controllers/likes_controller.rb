class LikesController < ApplicationController
  protect_from_forgery except: [:create, :destroy]
  before_action :logged_in_user

  def index
    @user = User.find(params[:user_id])
    @likes = @user.likes.order(created_at: "DESC").map(&:post)
  end

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    render 'likes/create.js.erb'
  end

  def destroy
    @post = current_user.likes.find_by(post_id: params[:post_id]).post
    current_user.unlike(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
end
