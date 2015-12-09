require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it {should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id)}

  describe ".involving(user)" do
    context 'When there are conversations involve a user' do
      let!(:user) { FactoryGirl.create(:user) }
      let(:conversation1) { FactoryGirl.create(:conversation, sender_id: user.id, recipient_id: 2) }
      let(:conversation2) { FactoryGirl.create(:conversation, sender_id: 3, recipient_id: user.id) }

      it "show all conversations involve a user" do
        expect(Conversation.involving(user)).to eq [conversation1, conversation2]
      end
    end

    context 'When no conversation involve a user' do
      let!(:current_user) { FactoryGirl.create(:user, email: "user@example.com") }
      let!(:sender) { FactoryGirl.create(:user, email: 'sender@example.com') }
      let!(:recipient) { FactoryGirl.create(:user, email: 'recipient@example.com') }
      let(:conversation) { FactoryGirl.create(:conversation, sender_id: sender.id, recipient_id: recipient.id) }

      it "conversation involve a user is a empty array" do
        expect(Conversation.involving(current_user)).to be_empty
      end
    end
  end

  describe ".between(sender_id, recipient_id)" do
    let!(:user1) { FactoryGirl.create(:user, email: "user1@example.com") }
    let!(:user2) { FactoryGirl.create(:user, email: 'user2@example.com') }
    let!(:conversation) { FactoryGirl.create(:conversation, sender_id: user1.id, recipient_id: user2.id) }

    it "show no conversation involve a user" do
      expect(Conversation.between(user1.id, user2.id)).to eq [conversation]
      expect(Conversation.between(user2.id, user1.id)).to eq [conversation]
    end
  end
end
