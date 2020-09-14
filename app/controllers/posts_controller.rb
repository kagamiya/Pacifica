class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
    @post.build_music
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, music_attributes: [:id, :name, :artist, :artwork, :collection_id])
    end

    # authorize correct user to access specific actions
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
