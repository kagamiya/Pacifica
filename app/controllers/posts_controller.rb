class PostsController < ApplicationController
  protect_from_forgery except: [:create, :destroy, :update]
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy, :edit, :update]

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.build
    @post.build_music
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to @post
    else
      @feed_items = []
      render 'posts/new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to root_url
  end

  def edit
    @post = Post.find(params[:id])
    @comment = Comment.new
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

  def search
    if params[:keyword].present? && params[:keyword].to_s.length >= 3
      @keyword = params[:keyword].split(/[[:blank:]]+/) # split with a blank
      @keyword.each do |keyword|
        next if keyword == ""

        @searched_posts = Post.joins(:music).select("posts.*, musics.*").where("name LIKE? OR artist LIKE?", "%#{keyword}%", "%#{keyword}%").paginate(page: params[:page])
        @searched_posts.uniq
      end
    else
      flash[:danger] = "Search keywords should not be empty or too short (atleast 3 characters)."
      redirect_to request.referer || root_url
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
