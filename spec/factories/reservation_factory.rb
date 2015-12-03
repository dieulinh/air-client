FactoryGirl.define do
  factory :reservation do |r|
    r.association :room, factory: :room
    start_date Time.zone.now
    end_date Time.zone.tomorrow
    price 235
    total 235
  end
end