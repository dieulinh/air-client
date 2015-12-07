class Conversation < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :involving, -> (user) {where("sender_id = ? OR recipient_id = ?", user.id, user.id)}

  scope :between, -> (sender, recipient) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)",
      sender.id, recipient.id, recipient.id, sender.id)
  end
end
