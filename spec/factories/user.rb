FactoryGirl.define do
  factory :user do
    first_name "Example"
    last_name "User"
    email "user@email.com"
    password "foobar123"
    password_confirmation "foobar123"
    provider nil
    authentication_token nil
    uid nil
    user_application
  
    factory :admin do
      last_name "Admin"
      email "admin@email.com"
      admin true
    end

    trait :facebook do
      provider "facebook"
      authentication_token "foo"
      uid "123"
    end

    factory :user_with_tools do
      ignore do
        tools_count 7
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:tool, evaluator.tools_count, user: user)
      end
    end

  end

end
