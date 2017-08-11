class TodoEvent < Event

  def self.createAddEvent(todo)
    project = todo.project
    team = project.team
    create(actor: todo.creator, resource: todo, project: project, team: team,
      action: 'add')
  end

  def self.createRemoveEvent(todo, actor)
    project = todo.project
    team = project.team
    create(actor: actor, resource: todo, project: project, team: team,
      action: 'remove')
  end

  def self.createFinishEvent(todo, actor)
    project = todo.project
    team = project.team
    create(actor: actor, resource: todo, project: project, team: team,
      action: 'finish')
  end

  def self.createAssignEvent(todo, actor, old_owner_id)
    project = todo.project
    team = project.team

    action = 'assign'
    action = 'update_assign' if old_owner_id != nil
    action = 'cancel_assign' if todo.owner_id == nil
    create(actor: actor, resource: todo, project: project, team: team,
      action: action, value: todo.owner_id, old_value: old_owner_id)
  end

  def self.createDueEvent(todo, actor, old_due_at)
    project = todo.project
    team = project.team
    create(actor: actor, resource: todo, project: project, team: team,
      action: 'due', value: todo.due_at&.to_s, old_value: old_due_at&.to_s)
  end

  alias_method :todo, :resource

  def cache_key
    key = [super]
    key << todo.updated_at.utc.to_s(:usec)
    key << actor.updated_at.utc.to_s(:usec)
    key << project.updated_at.utc.to_s(:usec)
    key.join('/')
  end

end