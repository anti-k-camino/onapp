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
    random_id 
    subject 'somesubject'
    body 'somebody'    
    department { create(:department) } 
    status { create(:status)}
    stuff_id nil
  end
end
