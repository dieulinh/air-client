class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  validates :sender_id, uniqueness: {scope: :recipient_id}

  scope :involving, -> (user) {where("sender_id = ? OR recipient_id = ?", user.id, user.id)}

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)",
      sender_id, recipient_id, recipient_id, sender_id)
  end
end
