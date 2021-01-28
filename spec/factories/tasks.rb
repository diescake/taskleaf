FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'これはテストです。これはテストです。これはテストです。' }
    user
  end
end
