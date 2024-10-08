class ApplicationController < ActionController::API

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def authorize
   if !(logged_in? || valid_bearer_token?)
     
     render_response(401, {:message => 'Not Authorized, please login to proceed'})
  
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
    if header && header.match(pattern) && header.gsub(pattern, '') == ENV['SUPERUSER_BEARER_TOKEN']
      true
    else 
      false
    end
  end

  def render_response(code, data)
    render json: Status.response(code, data), status: Status::MESSAGES[code]
  end

end
