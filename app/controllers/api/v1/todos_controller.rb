module Api
  module V1
    class TodosController < ApplicationController
      before_action :authorized?
  
       def create
  
         tc_response = TodoClient.new.create(params)
  
         render json: Status.response(202, tc_response.to_json), status: Status::CODES[202]
  
       end

       def index
  
         tc_response = TodoClient.new.recent_200.body
  
         render json: Status.response(202, tc_response), status: Status::CODES[202]
  
       end
  
       def destroy
  
         tc_response = TodoClient.new.delete(params["id"])
  
         render json: Status.response(202, tc_response.to_json), status: Status::CODES[202]
       end
  
     end
   end
 end