class ParentCompanyPolicy
  attr_reader :user, :parent_company

  def initialize(user, parent_company)
    @user = user
    @parent_company = parent_company
  end

  def edit?
    @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end

end
