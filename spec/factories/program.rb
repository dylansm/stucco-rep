FactoryGirl.define do
  factory :program do
    id 1
    name "Campus Ambassador Program"

    factory :program_with_students do
      ignore do
        student_count 2
      end

      after(:create) do |program, evaluator|
        FactoryGirl.create_list(:program_manager, evaluator.student_count, program: program)
      end
    end

  end
end
