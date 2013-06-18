FactoryGirl.define do
  factory :program do
    name "Campus Ambassador Program"

    factory :program_with_managers do
      ignore do
        program_managers_count 2
      end

      after(:create) do |program, evaluator|
        FactoryGirl.create_list(:program_manager, evaluator.program_managers_count, program: program)
      end
    end

  end
end
