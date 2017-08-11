FactoryGirl.define do
  factory :todo do
    title "fix some bugs"
    content "let's fix some bugs"
    project
    state 0
    creator
    owner_id nil
    due_at nil
  end
end
