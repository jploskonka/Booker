FactoryGirl.define do
  factory :bookmark do
    title { Faker::RockBand.name }
    url   { Faker::Internet.url }

    trait :unique do
      title { Faker::RockBand.unique.name }
      url   { Faker::Internet.unique.url }
    end
  end
end
