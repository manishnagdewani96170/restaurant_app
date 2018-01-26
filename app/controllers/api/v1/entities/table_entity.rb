module API::V1::Entities
  class TableEntity < Grape::Entity
    expose :id
    expose :name
    expose :maximum_count
    expose :minimum_count
    expose :restaurant do |table, options|
      table.restaurant.name
    end  
  end
end