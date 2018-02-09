FactoryBot.define do
  factory :raw_data do
    trait :for_update_with_no_match do
    end

    trait :for_update_with_invalid_match do
    end

    trait :for_update_with_valid_match do
    end
  end
end
