module API::V1::Entities
  class ReservationEntity < Grape::Entity
    expose :id
    expose :guest_count
    expose :reservation_time
    expose :table_name do |reservation|
      reservation.table.name
    end 
    expose :guest_name do |reservation|
      reservation.guest.name
    end 
  end
end