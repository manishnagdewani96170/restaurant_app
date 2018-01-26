FactoryGirl.define do
  factory :table do
    name { Faker::Name.name }
    minimum_count 2
    maximum_count 10
    restaurant
  end
end