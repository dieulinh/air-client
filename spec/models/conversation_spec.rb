require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it {should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id)}

  describe "Conversation.involving(user)" do
    context 'There are conversations involve a user' do
      let!(:user) { FactoryGirl.create(:user) }
      let(:conversation1) { FactoryGirl.create(:conversation, sender_id: user.id, recipient_id: 2) }
      let(:conversation2) { FactoryGirl.create(:conversation, sender_id: 3, recipient_id: user.id) }

      it "show all conversations involve a user" do
        expect(Conversation.involving(user)).to eq [conversation1, conversation2]
      end
    end

    context 'There are no conversation involve a user' do
      let!(:user1) { FactoryGirl.create(:user, email: "user1@example.com") }
      let!(:user2) { FactoryGirl.create(:user, email: 'user2@example.com') }
      let!(:user3) { FactoryGirl.create(:user, email: 'user3@example.com') }
      let(:conversation1) { FactoryGirl.create(:conversation, sender_id: user2.id, recipient_id: user3.id) }

      it "show no conversation involve a user" do
        expect(Conversation.involving(user1)).to eq []
      end
    end
  end

  describe "Conversation.between(sender_id, recipient_id)" do
    let!(:user1) { FactoryGirl.create(:user, email: "user1@example.com") }
    let!(:user2) { FactoryGirl.create(:user, email: 'user2@example.com') }
    let!(:conversation1) { FactoryGirl.create(:conversation, sender_id: user1.id, recipient_id: user2.id) }

    it "show no conversation involve a user" do
      expect(Conversation.between(user1.id, user2.id)).to eq [conversation1]
      expect(Conversation.between(user2.id, user1.id)).to eq [conversation1]
    end
  end
end
