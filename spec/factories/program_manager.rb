FactoryGirl.define do
  factory :program_manager do

    factory :manager_with_users do
      ignore do
        users_count 10
      end

      after(:create) do |program_manager, evaluator|
        FactoryGirl.create_list(:user, evaluator.users_count, program_manager: program_manager)
      end
    end
  end
end
