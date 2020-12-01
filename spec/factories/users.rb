FactoryBot.define do
  factory :user, class: User do
    sequence(:name){|n| "test_name_#{n}"}
    password { 'password' }
    password_confirmation { 'password' }
    sequence(:email){|n| "test_email_#{n}"}

    trait :fill_game_name do
      game_name { 'test' }
    end
  end
end
