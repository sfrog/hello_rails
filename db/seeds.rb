# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
team = Team.create(name: "A Team")

jason = User.create(name: "Jason", avatar: "https://tower.im/assets/default_avatars/nightfall.jpg")
ashley = User.create(name: "Ashley", avatar: "https://tower.im/assets/default_avatars/winter.jpg")

Access.create(user: jason, accessable: team, access_level: 1)
Access.create(user: ashley, accessable: team, access_level: 1)

feature_project = Project.create(name: "Feature Project", team: team)
bugfix_project = Project.create(name: "Bugfix Project", team: team)
wx_project = Project.create(name: "Weixin Project", team: team)

Access.create(user: jason, accessable: feature_project, access_level: 1)
Access.create(user: ashley, accessable: feature_project, access_level: 1)
Access.create(user: jason, accessable: bugfix_project, access_level: 1)
Access.create(user: ashley, accessable: bugfix_project, access_level: 1)

feature_todos = []
bug_todos = []
wx_todos = []

Timecop.travel(-80400*2) do
  for n in 1..3
    feature_todos << Todo.create(title: "添加页面#{n}", project: feature_project, creator: jason)
  end

  Timecop.travel(2000) do
    for n in 1..3
      bug_todos << Todo.create(title: "修复页面Bug#{n}", project: bugfix_project, creator: ashley)
    end
  end

  Timecop.travel(4000) do
    for n in 1..3
      wx_todos << Todo.create(title: "微信收发消息处理#{n}", project: wx_project, creator: ashley)
    end
  end

  Timecop.travel(6000) do
    feature_todos[0].assign_by(jason, ashley)
    feature_todos[0].change_due_by(jason, 1.day.from_now)
    feature_todos[1].assign_by(jason, ashley)

    wx_todos[0].assign_by(jason, ashley)
    wx_todos[0].change_due_by(jason, 1.day.from_now)
    wx_todos[1].assign_by(jason, ashley)
  end

  Timecop.travel(8000) do
    bug_todos[0].assign_by(jason, ashley)
    bug_todos[0].change_due_by(jason, 1.day.from_now)
    bug_todos[1].assign_by(jason, ashley)
    bug_todos[1].change_due_by(jason, 2.day.from_now)
    bug_todos[1].assign_by(ashley, jason)
    bug_todos[1].assign_by(jason, nil)
    bug_todos[1].change_due_by(jason, nil)
  end

  Timecop.travel(10000) do
    feature_todos[1].change_due_by(jason, 2.day.from_now)
    feature_todos[1].assign_by(ashley, jason)
    feature_todos[1].assign_by(jason, nil)
    feature_todos[1].change_due_by(jason, nil)

    wx_todos[1].change_due_by(jason, 2.day.from_now)
    wx_todos[1].assign_by(ashley, jason)
    wx_todos[1].assign_by(jason, nil)
    wx_todos[1].change_due_by(jason, nil)
  end
end


Timecop.travel(-80000) do
  feature_todos[2].assign_by(ashley, jason)
  feature_todos[2].change_due_by(ashley, 1.week.from_now)
  feature_todos[2].change_due_by(jason, 2.weeks.from_now)

  wx_todos[2].assign_by(ashley, jason)
  wx_todos[2].change_due_by(ashley, 1.week.from_now)
  wx_todos[2].change_due_by(jason, 2.weeks.from_now)

  Timecop.travel(3000) do
    bug_todos[2].assign_by(ashley, jason)
    bug_todos[2].change_due_by(ashley, 1.week.from_now)
    bug_todos[2].change_due_by(jason, 2.weeks.from_now)
    Comment.create(content: "搞定", user: ashley, commentable: bug_todos[0])
    Comment.create(content: "删了吧", user: ashley, commentable: bug_todos[1])
  end

  Timecop.travel(5000) do
    Comment.create(content: "搞定", user: ashley, commentable: feature_todos[0])
    Comment.create(content: "删了吧", user: ashley, commentable: feature_todos[1])
  end
end

feature_todos[0].finish_by(ashley)
feature_todos[1].remove_by(jason)
feature_todos[2].finish_by(jason)

wx_todos[0].finish_by(ashley)
wx_todos[1].remove_by(jason)
wx_todos[2].finish_by(jason)

Timecop.travel(7000) do
  bug_todos[0].finish_by(ashley)
  bug_todos[1].remove_by(jason)
  bug_todos[2].finish_by(jason)

  Comment.create(content: "OK", user: jason, commentable: bug_todos[0])
  Comment.create(content: "我看行", user: jason, commentable: bug_todos[1])
  Comment.create(content: "这么快", user: ashley, commentable: bug_todos[2])
  Comment.create(content: "是啊，超出预期", user: jason, commentable: bug_todos[2])
end

Timecop.travel(9000) do
  Comment.create(content: "OK", user: jason, commentable: feature_todos[0])
  Comment.create(content: "我看行", user: jason, commentable: feature_todos[1])
  Comment.create(content: "这么快", user: ashley, commentable: feature_todos[2])
  Comment.create(content: "是啊，超出预期", user: jason, commentable: feature_todos[2])
end

