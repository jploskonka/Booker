FactoryGirl.define do
  factory :site do
    url { Faker::Internet.unique.url }
  end
end
