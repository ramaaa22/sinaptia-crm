class ClientPolicy < ApplicationPolicy
  def edit?
    super && record.belongs_company?(user.company_id)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def index?
    record.belongs_company?(user.company_id)
  end
end
