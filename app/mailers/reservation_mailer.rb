class ReservationMailer < ApplicationMailer
  
  def send_reservation_detail_to_guest(reservation)
    @guest = @reservation.guest
    mail to: @guest.email, subject: "Reservation Details"
  end
  
  def send_reservation_detail_to_restaurant(reservation)
    @reservation = reservation
    mail to: @reservation.restaurant.email, subject: "Reservation Details"
  end 

  def send_updated_reservation_detail_to_guest(reservation, reservation_time, guest_count)
    @guest = @reservation.guest
    @reservation_time = reservation_time
    @guest_count = guest_count
    mail to: @guest.email, subject: "Updated Reservation Details"
  end 

end
