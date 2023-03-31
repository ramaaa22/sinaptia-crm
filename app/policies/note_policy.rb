class NotePolicy < ApplicationPolicy
  def create?
    record.client.belongs_company?(user.company_id)
  end

  def edit?
    (user.admin? || record.user_id == user.id) && record.client.belongs_company?(user.company_id)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
