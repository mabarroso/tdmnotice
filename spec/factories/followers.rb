# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follower do
    id 1
    screen_name "MyString"
    follow false
    notified_at "2012-08-21 00:12:07"
  end
end
