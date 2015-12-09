FactoryGirl.define do
  factory :message do
    content "MyText"
    conversation
    user
  end
end
