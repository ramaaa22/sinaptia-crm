class NotePolicy < ApplicationPolicy
  def update?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    update?
  end

  def create?
    true
  end
end
