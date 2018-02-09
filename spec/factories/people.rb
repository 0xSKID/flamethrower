FactoryBot.define do
  factory :person do
    account { create(:account) }
  end

  factory :matched do
    type 'Matched'
  end
end
