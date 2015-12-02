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
    let(:room) { FactoryGirl.attributes_for(:room).merge(user: user) }
    before { sign_in user }
    context 'success creating a room' do
      it 'should create a new room' do
        expect{ post :create, room:  room }.to change(Room, :count).by 1
      end
    end
  end
end
