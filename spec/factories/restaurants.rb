FactoryGirl.define do
  factory :restaurant do
    name { Faker::Name.name }
    email     { Faker::Internet.email }
    phone  '999-999-9999'
    morning_start_shift '10AM'
    morning_end_shift '1PM'
    evening_start_shift '6PM'
    evening_end_shift  '10PM'
  end
end