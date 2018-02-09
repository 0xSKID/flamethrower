FactoryBot.define do
  factory :person do
    account { create(:account) }
  end

  factory :matched do
    type 'Matched'
  end

  factory :replied do
    type 'Replied'
  end

  factory :responsive do
    type 'Responsive'
  end
end
