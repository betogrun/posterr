# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.username(specifier: 8)}#{n}" }
  end
end
