class TagPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def edit?
    super && record.belongs_company?(user.company_id)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
