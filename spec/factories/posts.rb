FactoryBot.define do
  factory :post do
    quest_name { 'テストクエスト' }
    invite_url { 'https://example.com' }
    user_id { user_id }
  end
end
