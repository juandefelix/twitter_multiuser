helpers do
  def set_current_user(new_user)
    session[:user_id] = new_user.id
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
