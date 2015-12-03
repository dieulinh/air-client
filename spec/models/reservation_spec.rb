require 'rails_helper'

RSpec.describe Reservation, type: :model do

  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
  context 'should have start_date is less than or equal end_date' do
    let(:reservation) { FactoryGirl.build(:reservation, end_date: Time.zone.yesterday) }

    it "show errors message" do
      reservation.validate
      expect(reservation.errors[:end_date]).to include("End date should greater than Start Date")
    end
  end
end