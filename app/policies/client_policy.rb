class ClientPolicy < ApplicationPolicy
  def index?
    record.belongs_company?(user.company_id)
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
