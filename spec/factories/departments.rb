FactoryGirl.define do

  sequence :title do |n|
    "somename#{n}"
  end

  factory :department do
    title 
  end
end
