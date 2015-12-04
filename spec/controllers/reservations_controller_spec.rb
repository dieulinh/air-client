require 'rails_helper'
RSpec.describe ReservationsController, type: :controller do
  describe 'GET #preload' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:room) { FactoryGirl.create(:room) }
    let!(:tomorrow_reservation) { FactoryGirl.create(:reservation, start_date: Time.zone.tomorrow, end_date: Time.zone.now + 16.days, room_id: room.id) }

    before { sign_in user }

    it "get all reservations unavailable next days" do
      get :preload, room_id: room.id
      expect(assigns(:reservations)).to include(tomorrow_reservation)
    end
  end
end