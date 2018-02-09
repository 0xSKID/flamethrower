FactoryBot.define do
  factory :update do
    account { create(:account) }

    trait :no_match do
      raw_data do
        create(:raw_data, :for_update_with_no_match)
      end
    end

    trait :invalid_match do
      raw_data do
        create(:raw_data, :for_update_with_invalid_match)
      end
    end

    trait :valid_match do
      raw_data do
        create(:raw_data, :for_update_with_valid_match)
      end
    end
  end
end
