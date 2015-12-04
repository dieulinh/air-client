require 'rails_helper'
RSpec.describe ReservationsController, type: :controller do
  describe 'ReservationsController' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:room) { FactoryGirl.create(:room) }
    let!(:tomorrow_reservation) { FactoryGirl.create(:reservation, start_date: Time.zone.tomorrow, end_date: Time.zone.now + 16.days, room_id: room.id) }

    before { sign_in user }

    describe 'GET #index' do
      let!(:user2) { FactoryGirl.create(:user, email: "user2@example.com") }
      let!(:user_room) { FactoryGirl.create(:room, user_id: user.id) }
      let!(:new_reservation) { FactoryGirl.create(:reservation, user_id: user2.id, room_id: user_room.id) }

      it "list all reservations of current_user" do
        get :index
        expect(assigns(:reservations)).to include new_reservation
      end
    end

    describe "GET #preload" do
      it "get all reservations unavailable next days" do
        get :preload, room_id: room.id
        expect(assigns(:reservations)).to include(tomorrow_reservation)
      end
    end

    describe "GET #preview" do
      it "show conflict if a new reservation has a reservation between start_date and end_date" do
        get :preview, room_id: room.id, start_date: Time.zone.now, end_date: Time.zone.now + 18.days
        expect(assigns(:conflict)).to eq true
      end
    end
  end
end