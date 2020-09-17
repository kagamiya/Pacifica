class StaticPagesController < ApplicationController
  def home
    if logged_in? && current_user.feed.any?
      @feed_items = current_user.feed.paginate(page: params[:page]) 
    end
  end

  def help
  end
end
