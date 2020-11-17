class StaticPagesController < ApplicationController
  def home
    unless logged_in?
      render 'home'
    else
      unless current_user.feed.blank?
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
        render 'home_feed'
      else
        render 'home_feed_nil'
      end
    end
  end

  def help; end
end
