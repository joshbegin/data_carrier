module ApplicationHelper
  def find_updater(id)
    User.find(id) unless id.nil?
  end
end
