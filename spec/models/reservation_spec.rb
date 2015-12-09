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
end