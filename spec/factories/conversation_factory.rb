FactoryGirl.define do
  factory :conversation do
    sender { create(:user, email: "sender@example.com") }
    recipient { create(:user, email: "recipient@example.com") }
  end
end
