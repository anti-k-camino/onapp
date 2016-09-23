FactoryGirl.define do
  sequence :name do |n|
    "MyString#{n}"
  end
  factory :stuff do
    name 
    password '123123'
    password_confirmation '123123'
  end
end
