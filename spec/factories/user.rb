
FactoryGirl.define do

  factory :user do
    sequence :name do |n|
      "name#{n}"
    end
    sequence :surname do |n|
      "surname#{n}"
    end
    sequence :email do |n|
      "first#{n}@example.com"
    end

    password               "password"
    password_confirmation  "password"

    trait :admin do
      self.role "admin"
    end

    trait :author do
      self.role "author"
    end

     trait :member do
      self.role "member"
    end
  end
end