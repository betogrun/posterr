# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    trait :original do
      kind { 'original' }
      content { Faker::Lorem.paragraph }
    end

    trait :repost do
      kind { 'repost' }
    end

    trait :quoted do
      kind { 'quoted' }
      quote { Faker::Lorem.question }
    end
  end
end
