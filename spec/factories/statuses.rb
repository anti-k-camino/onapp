FactoryGirl.define do

  sequence :state do |n|
    "MyState#{n}"
  end
  
  factory :status do
    state 
  end
end
