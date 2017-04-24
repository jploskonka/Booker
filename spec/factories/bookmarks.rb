FactoryGirl.define do
  factory :bookmark do
    title { Faker::RockBand.unique.name }
    url   { Faker::Internet.unique.url }

    site
  end
end
