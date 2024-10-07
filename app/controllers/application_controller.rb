class ApplicationController < ActionController::API

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def authorize
   if !(logged_in? || valid_bearer_token?)
     
     render_response(401, {:message => 'Not Authorized, please log in to proceed'}.to_json)
  
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

  def render_response(code, json)
    render json: Status.response(code, json), status: Status::CODES[code]
  end

end
