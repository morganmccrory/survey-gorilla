helpers do

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def choices_array
    choices_array ||= []
  end
end
