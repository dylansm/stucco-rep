FactoryGirl.define do
  factory :post do
    text "This is the body of the post"
    user

    trait :youtube do
      video_url "http://youtu.be/2oYJBtnPsp8"
    end

    trait :vimeo do
      video_url "http://vimeo.com/ondemand/somegirls/69277800"
    end
  end
end
