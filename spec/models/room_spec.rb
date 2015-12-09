require "rails_helper"

RSpec.describe Room, type: :model do
  it { should validate_presence_of :home_type }
  it { should validate_presence_of :room_type }
  it { should validate_presence_of :accommodate }
  it { should validate_presence_of :listing_name }
  it { should validate_presence_of :summary }
  it { should validate_presence_of :address }
  it { should validate_length_of(:listing_name).is_at_most(100) }
  it { should validate_length_of(:summary).is_at_most(500) }

  describe '#average_rating' do
    let!(:room) { FactoryGirl.create(:room) }
    let!(:user1) { FactoryGirl.create(:user, email: "user1@example.com") }
    let!(:user2) { FactoryGirl.create(:user, email: "user2@example.com") }
    let!(:review1) { FactoryGirl.create(:review, room: room, user: user1, star: 4) }
    let!(:review2) { FactoryGirl.create(:review, room: room, user: user2, star: 5) }
    it "should show the correct average value of rating" do
      expect(room.average_rating).to eq 4.5
    end
  end
end
