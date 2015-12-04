class Reservation < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  validate :start_date_must_be_earlier_than_end_date
  validates :start_date, presence: true
  validates :end_date, presence: true
  scope :in_between_range, -> (start_date, end_date) {where('? < start_date AND end_date < ?', start_date, end_date)}
  def start_date_must_be_earlier_than_end_date
    return if end_date.blank? or start_date.blank?
    errors.add(:end_date, "End date should greater than Start Date") if (end_date.to_date < start_date.to_date)
  end
end