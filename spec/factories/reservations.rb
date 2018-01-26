FactoryGirl.define do
  factory :reservation do
    guest
    restaurant
    table 
    guest_count 4
    reservation_time '6PM'
  end
end