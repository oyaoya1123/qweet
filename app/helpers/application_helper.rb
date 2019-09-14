module ApplicationHelper
  def current_user_has?(instance)
    user_signed_in? && current_user == instance.user
  end
end
