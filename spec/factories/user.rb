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
  
    trait :admin do
      last_name "Admin"
      email "admin@email.com"
      admin true
    end

    trait :facebook do
      provider "facebook"
      authentication_token "foo"
      uid "123"
    end
  end

end
