FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "email_#{n}@pm.com" }
    sequence(:f_name)     { |n| "f_name_#{n}" }
    sequence(:l_name)     { |n| "l_name_#{n}" }
    password              "password"
    password_confirmation "password"
    signup_code           "HAPPYNEWYEAR"
  end
  factory :property do
    sequence(:city)    { |n| "city_#{n}" } 
    sequence(:suburb)    { |n| "suburb_#{n}" } 
    sequence(:street)    { |n| "street_#{n}" } 
    sequence(:postcode)    { |n| "#{n}#{n}#{n}#{n}" } 
    sequence(:n_room)    { |n| "#{n}" } 
    sequence(:n_bathroom)    { |n| "#{n+1}" } 
  end
end
