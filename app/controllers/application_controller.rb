class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #methods are available to all other controllers
  #to make methods available to views, specify them
  helper_method :current_user, :logged_in?
  
  def current_user
    # memoisation: ||= saves this to current user instance variable
    # creates instance variable, no need to hid db every time
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id] 
  end
  
  #begin
  #  @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  #  rescue ActiveRecord::RecordNotFound => e
  #  @current_user = nil
  #end 
  
  #check if current user is logged in, returns boolean value
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to recipes_path
    end
  end
  
  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end
end
