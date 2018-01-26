module API::V1::Entities
  class RestaurantEntity < Grape::Entity
    expose :id
    expose :name
    expose :phone
    expose :email
  end
end