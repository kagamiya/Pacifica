class StaticPagesController < ApplicationController
  def home
    unless logged_in?
      render 'home'
    else
      unless current_user.feed.blank?
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      else
        @feed_items = []
      end
      render 'home_feed'
    end
  end

  def help; end
end
