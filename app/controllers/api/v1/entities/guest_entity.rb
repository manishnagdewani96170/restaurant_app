module API::V1::Entities
  class GuestEntity < Grape::Entity
    expose :id
    expose :name
    expose :email
  end
end
