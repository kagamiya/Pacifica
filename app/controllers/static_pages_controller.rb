class StaticPagesController < ApplicationController
  def home
    unless logged_in?
      render 'home'
    else
      if current_user.feed.blank?
        render 'home_feed_nil'
      else
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
        # render 'home_feed'
        render 'B'
      end
    end
  end

  def help; end
end
