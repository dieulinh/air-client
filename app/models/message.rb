class Message < ActiveRecord::Base
  belongs_to :conversation, dependent: :destroy
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  def sent_time
    created_at.strftime("%m/%e/%y %H:%M")
  end
end
