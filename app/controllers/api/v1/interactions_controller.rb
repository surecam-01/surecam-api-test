module Api
  module V1
    class InteractionsController < ApplicationController
      before_action :authorized?

      def create
        response = {}
  
        begin

          @interaction = Interaction.new(interaction_params)
          
          @interaction.type = interaction_type
          
          if @interaction.type.downcase == Interaction::TYPE_NAMES[1].downcase && !@interaction.parent_interaction_id.nil?
            title = Interaction.where(:id => params["parent_interaction_id"].to_i).pluck(:title).first
            @interaction.title = "Re: #{title}"
          end


          if @interaction.save!

            response[:message] = "#{@interaction.type} (#{@interaction.id}) created"

            render json: Status.response(201, response.to_json), status: Status::CODES[201]
          else
            raise StandardError, "Interaction could not be saved"
          end
        
        rescue Exception => e

          response.merge!({
            :message => "#{interaction_type} not created",
            :details => e,
            :backtrace => e.backtrace
          })
        
          render json: Status.response(422, response.to_json), status: Status::CODES[422]
        
        end
      end

      def destroy

        response = {}

        @interaction = Interaction.find(params["id"])

        begin

          if @interaction.destroy
            response[:message] = "#{interaction_type} with id(#{params["id"]}) deleted"

            if interaction_type == Interaction::TYPE_NAMES[0]
              comments = Comment.where(:parent_interaction_id => params["id"])
              comment_total = comments.length
              comments.destroy_all
              response[:message] += " and comments deleted (#{comment_total})"
            end

            render json: Status.response(202, response.to_json), status: Status::CODES[202]

          else

            raise StandardError, "Something went wrong"

          end
        rescue Exception => e

          response.merge!({
            :message => "#{interaction_type} with id(#{params["id"]}) not deleted",
            :details => e,
            :backtrace => e.backtrace
          })

          render json: Status.response(405, response.to_json), status: Status::CODES[405]

        end
      end

      private

      def interaction_params
        params.permit(:type, :title, :raw, :user_id, :parent_interaction_id)
      end

      def interaction_type
        params[:controller].split("/").last.delete_suffix!('s').titleize || Parent.whoami
      end
    end
  end
end
