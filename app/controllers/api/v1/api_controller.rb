module Api
    module V1
      class ApiController < ApplicationController

        INDEX_RESPONSE = {
          :status => :ok,
          :code => 200,
          :content => 'application/json',
          :title => 'surecam-test-api',
          :version => 'v1',
          :domain => nil,
          :api => 'api/v1',
          :developer => 'William Morgan',
          :timestamp => nil
        }
  
        def index
          response = { 
            :domain => request.domain,
            :timestamp => Time.now,
            :routes => routes
          }

          render json:  JSON.pretty_generate(INDEX_RESPONSE.merge(response)), status: Status::CODES[200]
        end
  
        def routes

          # finds api/v1 routes only

          Rails.application.routes.routes.flat_map do |route| 

            route.path.spec.to_s

          end.uniq.select do |path|

            if /api\/v1/.match?(path)
              path.gsub('(.:format)', '')
            end

          end
      end 
    end
  end
end
  