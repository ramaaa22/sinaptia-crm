class NotePolicy < ApplicationPolicy
  def update?
    (user.admin? || record.user_id == user.id) && record.client.belongs_company?(user.company_id)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def create?
    record.client.belongs_company?(user.company_id)
  end
end
