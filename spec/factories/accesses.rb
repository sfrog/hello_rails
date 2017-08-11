FactoryGirl.define do
  factory :project_access, class: "Access" do
    user
    association :accessable, factory: :project
    access_level 3
  end

  factory :team_access, class: "Access" do
    user
    association :accessable, factory: :team
    access_level 3
  end
end
