require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  describe 'GET #index' do
    let!(:user) { FactoryGirl.create(:user, email: 'user@example.com') }
    let!(:user1) { FactoryGirl.create(:user, email: 'user1@example.com') }
    let!(:user2) { FactoryGirl.create(:user, email: 'user2@example.com') }
    let!(:conversation1) { FactoryGirl.create(:conversation, sender_id: user.id, recipient_id: user1.id) }
    let!(:conversation2) { FactoryGirl.create(:conversation, sender_id: user.id, recipient_id: user2.id) }
    let!(:conversation3) { FactoryGirl.create(:conversation, sender_id: user1.id, recipient_id: user2.id) }

    before do
      sign_in user
    end

    it "current user can list all conversations he created" do
      get :index
      expect(assigns(:conversations)).to eq [conversation1, conversation2]
    end
  end


end
