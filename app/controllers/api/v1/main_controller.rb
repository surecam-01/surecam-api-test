module Api
    module V1
      class MainController < ApplicationController
  
        def index
          response = { 
            :base_url => request.host_with_port,
            :path => request.fullpath.split("/")[0..2].join("/"),
            :routes => routes
          }

          render_response(200, Main::RESPONSE.merge(response).to_json)
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
  