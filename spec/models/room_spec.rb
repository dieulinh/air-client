require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should validate_presence_of :home_type }
  it { should validate_presence_of :room_type }
  it { should validate_presence_of :accommodate }
  it { should validate_presence_of :listing_name }
  it { should validate_presence_of :summary }
  it { should validate_presence_of :address }
  it { should validate_length_of(:listing_name).is_at_most(100) }
  it { should validate_length_of(:summary).is_at_most(500) }
end
