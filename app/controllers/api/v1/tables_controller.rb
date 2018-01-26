module API
  module V1
    class TablesController < Grape::API
      include API::V1::Defaults

      resource :tables do
        
        desc 'Return Table info'
        params do
          requires :id, type: Integer
        end
        
        route_param :id do
          get do
            present @table, with: API::V1::Entities::TableEntity
          end
        end  

        desc 'Create Table'
        params do
          requires :table, type: Hash do
            requires :name, type: String
            requires :maximum_count, type: Integer
            requires :minimum_count, type: Integer
            requires :restaurant_id, type: Integer
          end  
        end
        post do
          @table = Table.create(permitted_params[:table])
          present @table, with: API::V1::Entities::TableEntity
        end  
      end

    end
  end
end      