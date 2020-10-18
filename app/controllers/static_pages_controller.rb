class StaticPagesController < ApplicationController
  def home
    return unless logged_in? && current_user.feed.any?

    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
  end

  def help; end
end
