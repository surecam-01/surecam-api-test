module Api
  module V1
    class InteractionsController < ApplicationController
      before_action :authorize

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

            render_response(201, response)
          else
            raise StandardError, "Interaction could not be saved"
          end
        
        rescue Exception => e

          response.merge!({
            :message => "#{interaction_type} not created",
            :details => e,
            :backtrace => e.backtrace
          })
        
          render_response(422, response)
        
        end
      end

      def destroy

        response = {}

        @interaction = Interaction.find(params["id"])
        descendants = @interaction.descendants

        begin

          if @interaction.destroy
            response[:message] = "#{interaction_type} with id (#{params["id"]}) deleted"

            if interaction_type.downcase == Interaction::TYPE_NAMES[0].downcase

              comment_total = Interaction.batch_delete(descendants)

              if comment_total > 0
              
                response[:message] += " and (#{comment_total}) nested comment#{comment_total > 1 ? "s":""} also deleted"
                
              end
            end

            render_response(202, response)

          else

            raise StandardError, "Something went wrong"

          end
        rescue Exception => e

          response.merge!({
            :message => "#{interaction_type} with id (#{params["id"]}) not deleted",
            :details => e,
            :backtrace => e.backtrace
          })

          render_response(405, response)

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
