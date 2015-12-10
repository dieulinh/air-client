class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :room, presence: true
end