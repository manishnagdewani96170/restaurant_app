describe API::V1::ReservationsController, type: :request do
  
  context 'POST /api/v1/reservations' do
    let(:restaurant) { create(:restaurant) }
    let(:table) { create(:table) }
    let(:guest) { create(:guest) }

  
    before do
      Grape::Endpoint.before_each do |endpoint|
        allow(endpoint).to receive(:check_reservation_time).and_return(true)
        allow(endpoint).to receive(:check_guest_count).and_return(true)
      end
    end

    it 'create a reservation' do
      reservation = {reservation: { reservation_time: '10AM', guest_count: 10, restaurant_id: restaurant.id, table_id: table.id, guest_id: guest.id}}
      post '/api/v1/reservations', reservation.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(response.status).to eq 201
    end

  end

  context 'PUT /api/v1/reservations/:id' do
    let(:reservation) { create(:reservation) }

  
    before do
      Grape::Endpoint.before_each do |endpoint|
        allow(endpoint).to receive(:check_reservation_time).and_return(true)
        allow(endpoint).to receive(:check_guest_count).and_return(true)
      end
    end

    it 'update a reservation' do 
      reservation_hash = { reservation_time: '11AM', guest_count: 8}
      put "/api/v1/reservations/#{reservation.id}", reservation_hash.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(response.status).to eq 200
    end

  end

  context 'GET /api/v1/reservations?restaurant_id' do
    let(:restaurant) { create(:restaurant) }

    it 'returns a reservation by restaurant_id' do
      get "/api/v1/reservations?restaurant_id=#{restaurant.id}"
      expect(response.body).to eq restaurant.to_json
    end
  end
end
