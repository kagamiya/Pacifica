module SessionsHelper
  # log in as the passed user
  def log_in(user)
    session[:user_id] = user.id
  end

  # make an user session permanent
  def remember(user)
    user.remember_new_token
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # return the user associated with a cookie of remember token
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true when the passed user is current user
  def current_user?(user)
    user == current_user
  end

  # return true when user is logged in
  def logged_in?
    !current_user.nil?
  end

  # discard a permanent session
  def forget(user)
    user.forget_token
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # log out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # redirect to the memorized URL (or the default URL)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # memorize URL which an user would access
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
