require "rails_helper"

RSpec.describe Reservation, type: :model do

  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }

  describe "should have start_date is less than or equal end_date" do

    context "When user input start_date greater than end_date" do
      let(:reservation) { FactoryGirl.build(:reservation, start_date: Time.zone.today, end_date: Time.zone.yesterday) }
      it "show errors message" do
        reservation.validate
        expect(reservation.errors[:end_date]).to include("End date should greater than Start Date")
      end
    end
    context "When user input valid end_date" do
      let(:reservation) { FactoryGirl.build(:reservation, start_date: Time.zone.today, end_date: Time.zone.tomorrow) }
      it "not contain errors message on end_date field" do
        reservation.validate
        expect(reservation.errors[:end_date]).to_not include("End date should greater than Start Date")
      end
    end
  end

  describe '.room_booked_by_user?(room, user)' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:room) { FactoryGirl.create(:room) }
    let!(:reservation) { FactoryGirl.create(:reservation, user: user, room: room, start_date: Time.zone.yesterday, end_date: Time.zone.today) }
    it "should return true if user has a reservation with a room" do
      expect(Reservation.room_booked_by_user?(room, user)).to be true
    end
  end
end