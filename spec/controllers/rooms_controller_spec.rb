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
end
