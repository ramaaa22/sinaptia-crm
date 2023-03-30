class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def edit?
    super && user.id != record.id && !record.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
