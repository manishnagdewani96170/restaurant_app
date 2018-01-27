module API
  module V1
    class ReservationsController < Grape::API
      include API::V1::Defaults

      resource :reservations do
        
        helpers do  
          def check_reservation_time
            table = Table.find(permitted_params[:reservation][:table_id])
            restaurant = table.restaurant
            reservation_time = Time.parse(permitted_params[:reservation][:reservation_time])
            if reservation_time > Time.parse(restaurant.morning_start_shift) && reservation_time < Time.parse(restaurant.morning_end_shift) ||
            reservation_time > Time.parse(restaurant.evening_start_shift) && reservation_time < Time.parse(restaurant.evening_end_shift)          
              return true
            else
              throw :error, message: 'Please select valid reservation time', status: 406 
            end    
          end

          def check_guest_count 
            table = Table.find(permitted_params[:reservation][:table_id])
            if (table.minimum_count..table.maximum_count).include?(permitted_params[:reservation][:guest_count].to_i)
              return true
            else
              throw :error, message: 'Please select valid guest count', status: 406 
            end  
          end  
        end  
        
        desc 'Return Reservation info'
        params do
          requires :id, type: Integer
        end
        
        route_param :id do
          get do
            present @reservation, with: API::V1::Entities::ReservationEntity
          end
        end  

        
        desc 'Update reservation.'
        params do
          requires :id, type: Integer
          requires :reservation, type: Hash do
            optional :reservation_time, type: String
            optional :guest_count, type: Integer
          end  
        end
        put ':id' do
          check_reservation_time
          check_guest_count
          @reservation = Reservation.find(permitted_params[:id])
          @reservation_time = @reservation.reservation_time
          @guest_count = @reservation.guest_count
          @reservation.update(permitted_params[:reservation])
          ReservationMailer.send_updated_reservation_detail_to_guest(@reservation, @reservation_time, @guest_count).deliver_later!
          present @reservation, with: API::V1::Entities::ReservationEntity
        end

        desc 'Create Reservation'
        params do
          requires :reservation, type: Hash do
            requires :reservation_time, type: String
            requires :restaurant_id, type: Integer
            requires :table_id, type: String
            requires :guest_count, type: String
            requires :guest_id, type: String
          end  
        end
        post do
          check_reservation_time
          check_guest_count
          @reservation = Reservation.create(permitted_params[:reservation])
          if @reservation.save!
            ReservationMailer.send_reservation_detail_to_restaurant(@reservation).deliver_later!
            ReservationMailer.send_reservation_detail_to_guest(@reservation).deliver_later!
            present @reservation, with: API::V1::Entities::ReservationEntity
          end  
        end

        desc 'Reservation List'
        params do
          requires :restaurant_id, type: Integer
        end  
        get do
          @restaurant = Restaurant.find(permitted_params[:restaurant_id])
          @reservations = @restaurant.reservations.limit(10)
          present @reservations, with: API::V1::Entities::ReservationEntity
        end  
      end
    end
  end
end