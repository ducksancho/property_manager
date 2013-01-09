FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "email_#{n}@pm.com" }
    sequence(:f_name)     { |n| "f_name_#{n}" }
    sequence(:l_name)     { |n| "l_name_#{n}" }
    password              "password"
    password_confirmation "password"
    signup_code           "HAPPYNEWYEAR"
  end
end
