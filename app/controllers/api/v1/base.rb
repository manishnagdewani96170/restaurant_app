module API
  module V1
    class Base < Grape::API
      mount API::V1::RestaurantsController
      mount API::V1::GuestsController
      mount API::V1::ReservationsController
      mount API::V1::TablesController
    end
  end
end
