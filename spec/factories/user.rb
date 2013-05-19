FactoryGirl.define do
  factory :user do
    first_name "Example"
    last_name "User"
    email "user@email.com"
    password "foobar123"
    password_confirmation "foobar123"
  
    trait :admin do
      last_name "Admin"
      email "admin@email.com"
      admin true
    end
  end
end
