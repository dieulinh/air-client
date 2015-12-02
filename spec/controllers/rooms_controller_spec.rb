require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'GET #index' do
    let!(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      FactoryGirl.create_list(:room, 3, user: user)
    end

    it "current user can list all rooms he created" do
      get :index
      expect(assigns(:rooms).size).to eq 3
    end
  end

  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:user) }

    before { sign_in user }
    context 'success creating a room' do
      let(:room) { FactoryGirl.attributes_for(:room) }
      it 'should create a new room' do
        expect{ post :create, room:  room }.to change(Room, :count).by 1
      end
    end

    context 'fail to create a room' do
      let(:room) { FactoryGirl.attributes_for(:room, home_type: nil) }
      it 'not create a room in case invalid data for a room' do
        expect{ post :create, room:  room }.not_to change(Room, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { FactoryGirl.create(:user) }

    before do
     sign_in user
    end
    context 'success creating a room' do
      let!(:room) { FactoryGirl.create(:room) }
      it 'should update new value for a room' do
        put :update, id: room.id, room: FactoryGirl.attributes_for(:room, listing_name: "this is a  new room")
        room.reload
        expect(room.listing_name).to eq "this is a  new room"
      end
    end
  end
end
