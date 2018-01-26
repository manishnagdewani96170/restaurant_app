module API
  module V1
    class GuestsController < Grape::API
      include API::V1::Defaults

      resource :guests do
        
        desc 'Return Guest info'
        params do
          requires :id, type: Integer
        end
        
        route_param :id do
          get do
            present @guest, with: API::V1::Entities::GuestEntity
          end
        end  

        desc 'Create Guest'
        params do
          requires :guest, type: Hash do
            requires :name, type: String
            requires :email, type: String
          end  
        end
        post do
          @guest = Guest.create(permitted_params[:guest])
          present @guest, with: API::V1::Entities::GuestEntity
        end

        desc 'Guest List'
        get do
          Guest.limit(10)
        end  
      end
    end
  end
end