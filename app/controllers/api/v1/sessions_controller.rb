module Api
  module V1
    class SessionsController < ApplicationController
  
      def create

        @user = User.find_by(email: params[:email])
        response = {}

        if @user.present? && @user.authenticate(params[:password])

          session[:user_id] = @user.id
  
          response[:message] = "Successfully logged in"

          render_response(200, response)

        else

          response[:message] = "Invalid email or password"

          render_response(403, response)

        end

      end

      def destroy
  
        response = {}
        
        begin

          if logout
            
            response[:message] = "User with id (#{params["id"]}) signed out"

            render_response(200, response)

          else

            raise StandardError, "User with id (#{params["id"]}) not signed out"
            
          end
        rescue Exception => e

          response.merge!({

            :message => "Something went wrong",
            :details => e,
            :backtrace => e.backtrace

          })

          render_response(400, response)

        end
      end

    end
  end
end
