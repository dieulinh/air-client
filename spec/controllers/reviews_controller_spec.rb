require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  describe "POST #create" do
    let(:user) { FactoryGirl.create(:user, email: 'user@example.com') }
    let(:room) { FactoryGirl.create(:room) }

    before do
      @review_attr = {room_id: room.id, star: 5, comment: "This is a comment."}
      sign_in user
    end

    it "creates a new review" do
      expect{ post :create, room_id: room.id, review: @review_attr }.to change(Review, :count).by 1
    end
  end
end
