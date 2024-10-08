module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize, only: [:index, :show, :destroy]

      def create

        response = {}

        begin

          @user = User.new(user_params)

          @user.user_type = :registered

          if @user.save!
            user_attributes = @user.attributes.clone
            user_attributes.delete('user_type')

            response.merge!({

              :message => "User successfully created",
              :user => user_attributes,
              :jwt => JWT.encode({user_id: @user.id}, ENV['JWT_SECRET'], 'HS256') # for future use

            })

            response[:user].delete('password_digest')

            render_response(201, response)

          else

            response[:message] = "User not created"

            render_response(422, response)

          end
  
        rescue Exception => e
          
          response.merge!({
          
            :message => "An error occurred",
            :details => e,
            :backtrace => e.backtrace
  
          })

          render_response(400, response)

        end
      end

      def index

        response = User.all.select(:id, :email, :username, :created_at, :updated_at)

        render_response(200, response)
  
      end

      def show

        response = {}
  
        begin

          response[:user] = User.where(:id => params["id"]).select(:id, :email, :username, :created_at, :updated_at)

          raise StandardError, "User with id (#{params["id"]}) does not exist" if response[:user].length == 0 
        
          response[:posts] = Post.where(:user_id => params["id"])
          response[:comments] = Comment.where(:user_id => params["id"])

          render_response(200, response)
        
        rescue Exception => e

          # remove key from response
          response.delete(:user)
          response.merge!({

            :details => e,
            :backtrace => e.backtrace

          })
    
          render_response(400, response)
        
        end
      end

      def destroy
  
        response = {}

        begin
  
          @user = User.find(id: params["id"])
  
          if @user.destroy
  
            response[:message] = "User with id (#{params["id"]}) deleted"
            
            render_response(202, response)

          else

            raise StandardError, "Error with deletion"

          end
  
        rescue Exception => e

          response.merge!({
  
            :message => "User with id (#{params["id"]}) could not be deleted",
            :details => e,
            :backtrace => e.backtrace

          })

          render_response(405, response)

        end


      end

      private

        def user_params
          params.permit(:email, :username, :password, :password_confirmation)
        end

    end
  end
end