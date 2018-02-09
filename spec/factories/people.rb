FactoryBot.define do
  factory :person do
    account { create(:account) }
  end
end
