FactoryGirl.define do
  factory :add_todo_event, class: 'TodoEvent' do
    actor
    association :resource, factory: :todo
    project
    team
    action "add"
    value "MyString"
    old_value "MyString"
  end

  factory :add_comment_event, class: 'CommentEvent' do
    actor
    association :resource, factory: :comment
    project
    team
    action "add"
    value "MyString"
    old_value "MyString"
  end
end
