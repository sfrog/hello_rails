class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :events, as: :resource

  after_create :send_add_event

  def owner
    User.find(owner_id)
  end

  def finished?
    (state & 1) == 1
  end

  def removed?
    (state & 2) == 2
  end

  def remove_by(user)
    Todo.transaction do
      update(state: state_removed(state))
      send_remove_event(user)
    end
  end

  def recover_by(user)
    update(state: state_recovered(state))
  end

  def finish_by(user)
    Todo.transaction do
      update(state: state_finished(state))
      send_finish_event(user)
    end
  end

  def unfinish_by(user)
    update(state: state_unfinished(state))
  end

  def assign_by(user, owner)
    unless owner_id == owner&.id
      old_owner_id = owner_id
      Todo.transaction do
        update(owner_id: owner&.id)
        send_assign_event(user, old_owner_id)
      end
    end
  end

  def change_due_by(user, date)
    unless due_at == date
      old_due_at = due_at
      Todo.transaction do
        update(due_at: date)
        send_due_event(user, old_due_at)
      end
    end
  end

private

  def state_removed(state)
    state | 2
  end

  def state_recovered(state)
    state & 1
  end

  def state_finished(state)
    state | 1
  end

  def state_unfinished(state)
    state & 2
  end

  def send_add_event
    TodoEvent.createAddEvent(self)
  end

  def send_remove_event(actor)
    TodoEvent.createRemoveEvent(self, actor)
  end

  def send_finish_event(actor)
    TodoEvent.createFinishEvent(self, actor)
  end

  def send_assign_event(actor, old_owner_id)
    TodoEvent.createAssignEvent(self, actor, old_owner_id)
  end

  def send_due_event(actor, old_due_at)
    TodoEvent.createDueEvent(self, actor, old_due_at)
  end
end
