FactoryGirl.define do
  factory :task do
    name "MyString#{n}"
    description "MyText"
    user_id 1
    priority 1
    expired_on 1.week.from_now
    status 1
  end
end
