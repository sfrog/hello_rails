FactoryGirl.define do
  factory :comment do
    content "This todo is awesome"
    user
    association :commentable, factory: :todo
  end
end
