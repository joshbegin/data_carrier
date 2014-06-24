class HomeController < ApplicationController
  def index
    @users = User.all
    @recent_companies = Company.recently_updated(5)
    @recent_parent_companies = ParentCompany.recently_updated(5)
  end
end
