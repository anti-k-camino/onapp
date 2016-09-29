FactoryGirl.define do
  sequence :email do |n|
    "some#{n}@email.com"
  end
  sequence :random_id do |n|
    "AAA-1a-BBB-#{n}b-CCC"
  end
  factory :ticket do
    name 'somename'
    email    
    status 0
    random_id 
    subject 'somesubject'
    body 'somebody'    
    department { create(:department) } 
  end
end
