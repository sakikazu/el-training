FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    user_id 1
    priority 1
    expired_on "2018-03-23"
    status 1
  end
end
