class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  # after this, rails would recognize the above two as the helper methods

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
    
    #User.find 에서 session에 있는 아이디를 써서 full detail을 가져온다. 
    #기본적으로 session의 user.id은 엠티이다. 나중에 정해준다. 
    # 그다음 이 아이디를 바탕으로 해서, 나중에 개인의 인증이 필요하면 풀 디테일을 가져온다
    # if current user is not true, latter parts. 
    
  end

  def logged_in?
    !!current_user
    # !! turn eveyring into boolean. 
    # if currnet_user is true, true
    
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must log in to perform that action"
      redirect_to root_path
    end
    
  end
end
