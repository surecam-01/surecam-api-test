module Api
  module V1
    class SessionsController < ApplicationController
  
      def create

        user = User.find_by(email: params[:email])
        response = {}

        if user.present? && user.authenticate(params[:password])

          session[:user_id] = user.id

          # for future use
          session[:jwt] = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'], 'HS256')
  
          response[:message] = "Successfully logged in"

          render json: Status.response(200, response.to_json), status: Status::CODES[200]

        else

          response[:message] = "Invalid email or password"

          render json: Status.response(403, response.to_json), status: Status::CODES[403]

        end

      end

      def destroy
  
        response = {}
        
        begin

          if logout
            
            response[:message] = "User with id (#{params["id"]}) signed out"

            render json: Status.response(200, response.to_json), status: Status::CODES[200]

          else

            raise StandardError, "User with id (#{params["id"]}) not signed out"
            
          end
        rescue Exception => e

          response.merge!({

            :message => "Something went wrong",
            :details => e,
            :backtrace => e.backtrace

          })

          render json: Status.response(400, response.to_json), status: Status::CODES[400]

        end
      end

    end
  end
end
