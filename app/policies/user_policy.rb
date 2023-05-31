class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def edit?
    index? && user.id != record.id && !record.admin? && record.accepted?
  end

  def update?
    edit?
  end

  def destroy?
    edit? && !record.discarded?
  end

  def restore?
    edit? && record.discarded?
  end

  def accept?
    user.admin? && !record.accepted?
  end
end
