FactoryGirl.define do
  factory :review do
    room
    user
    star 5
    comment "Great room"
  end
end