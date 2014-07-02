module ApplicationHelper
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def find_updater(id)
    User.find(id) unless id.nil?
  end
end
