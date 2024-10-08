module Api
  module V1
    class TodosController < ApplicationController
      before_action :authorize
  
       def create
  
         tc_response = TodoClient.new.create(params)
  
         render_response(202, tc_response)
  
       end

       def index
  
         tc_response = TodoClient.new.recent_200
  
         render_response(202, tc_response)
  
       end
  
       def destroy
  
         tc_response = TodoClient.new.delete(params["id"])
  
         render_response(202, tc_response)
  
       end
  
     end
   end
 end