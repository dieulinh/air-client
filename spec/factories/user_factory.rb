FactoryGirl.define do
  factory :user, class: "User" do
    fullname "John Smith"
    email "johnsmith@example.com"
    password "123123123"
    password_confirmation "123123123"
  end
end