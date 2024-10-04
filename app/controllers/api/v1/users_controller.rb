module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized?, only: [:index, :show, :destroy]

      def new

        response = {}
        response[:user] = User.new
      
        render json: Status.response(200, response.to_json), status: Status::CODES[200]

      end

      def create

        response = {}

        begin

          @user = User.new(user_params)

          @user.user_type = :registered

          if @user.save!

            response.merge!({

              :message => "User successfully created",
              :user => @user.attributes.clone,
              :jwt => JWT.encode({user_id: @user.id}, ENV['JWT_SECRET'], 'HS256')

            })

            response[:user].delete('password_digest')

            render json: Status.response(201, response.to_json), status: Status::CODES[201]

          else

            response[:message] = "User not created"

            render json: Status.response(422, response.to_json), status: Status::CODES[422]

          end
  
        rescue Exception => e
          
          response.merge!({
          
            :message => "An error occurred",
            :details => e,
            :backtrace => e.backtrace
  
          })

          render json: Status.response(400, response.to_json), status: Status::CODES[400]

        end
      end

      def index

        response = User.all.select(:id, :email, :username, :created_at, :updated_at).to_json

        render json: Status.response(200, response), status: Status::CODES[200]
  
      end

      def show

        response = {}
  
        begin

          response[:user] = User.where(:id => params["id"]).select(:id, :email, :username, :created_at, :updated_at)

          raise StandardError, "User with id (#{params["id"]}) does not exist" if response[:user].length == 0 
        
          response[:posts] = Post.where(:user_id => params["id"])
          response[:comments] = Comment.where(:user_id => params["id"])

          render json: Status.response(200, response.to_json), status: Status::CODES[200]
        
        rescue Exception => e

          # remove key from response
          response.delete(:user)
          response.merge!({

            :details => e,
            :backtrace => e.backtrace

          })
    
          render json: Status.response(400, response.to_json), status: Status::CODES[400]
        
        end
      end

      def destroy
  
        response = {}

        begin
  
          @user = User.find(id: params["id"])
  
          if @user.destroy
  
            response[:message] = "User with id (#{params["id"]}) deleted"
            
            render json: Status.response(202, response.to_json), status: Status::CODES[202]

          else

            raise StandardError, "Error with deletion"

          end
  
        rescue Exception => e

          response.merge!({
  
            :message => "User with id (#{params["id"]}) could not be deleted",
            :details => e,
            :backtrace => e.backtrace

          })

          render json: Status.response(405, response.to_json), status: Status::CODES[405]

        end


      end

      private

        def user_params
          params.permit(:email, :username, :password, :password_confirmation)
        end

    end
  end
end