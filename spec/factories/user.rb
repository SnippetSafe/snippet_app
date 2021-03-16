FactoryBot.define do
  factory :user do
    name { 'LewisYoul' }
    email { 'lewisyoul@gmail.com' }
    password { '12345676543!@£$@ytrefgKJHGFG' }
    confirmed_at { Date.today }
  end
end