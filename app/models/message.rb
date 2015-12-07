class Message < ActiveRecord::Base
  belongs_to :conversation, dependent: :destroy
  belongs_to :user

  validates_presence_of :content, :user_id, :conversation_id

  def sent_time
    created_at.strftime("%m/%e/%y %H:%M")
  end
end
