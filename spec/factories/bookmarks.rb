FactoryGirl.define do
  factory :bookmark do
    title { Faker::StarWars.planet }
    url   { Faker::Internet.url }
  end
end
