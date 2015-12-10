FactoryGirl.define do
  factory :room do
    home_type "House"
    room_type "Entire"
    bed_room 2
    bath_room 2
    accommodate 4
    active true
    summary "This room has a nice view nearby SG river"
    listing_name "it good for a small family"
    is_tv false
    is_heating true
    price 250
    address "92 Nguyen Huu Canh"
  end
end