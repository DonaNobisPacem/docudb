FactoryGirl.define do
  factory :office do
    name { FFaker::Company.name }
  end
end
