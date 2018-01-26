module API
  module V1
    class RestaurantsController < Grape::API
      include API::V1::Defaults

      resource :guests do
        
        desc 'Return Restaurant info'
        params do
          requires :id, type: Integer
        end
        
        route_param :id do
          get do
            present @restaurant, with: API::V1::Entities::RestaurantEntity
          end
        end  

        desc 'Create Restaurant'
        params do
          requires :restaurant, type: Hash do
            requires :name, type: String
            requires :phone, type: String
            requires :email, type: String
          end  
        end
        post do
          @restaurant = Restaurant.create(permitted_params[:restaurant])
          present @restaurant, with: API::V1::Entities::RestaurantEntity
        end

        desc 'Restaurant List'
        get do
          Restaurant.limit(10)
        end  
      end

    end
  end
end      