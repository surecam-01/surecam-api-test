class ApplicationController < ActionController::API

  #helper_method :logged_in?, :current_user

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def authorized?
   if !(logged_in? || valid_bearer_token?)
     
     render json: Status.response(401, {:message => 'Not Authorized, please log in to proceed'}.to_json), status: Status::CODES[401]
  
   end
  end

  def logout
    begin
      session.clear
      true
    rescue Exception
      false
    end
  end

  def logged_in?
    !!current_user
  end

  def valid_bearer_token?
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    if header && header.match(pattern)
      true
    else 
      false
    end
  end

end
