module TopicsHelper
  def user_is_admin_authorized_for_topics?
       current_user && current_user.admin?
  end
  def user_is_moderator_authorized_for_topics?
       (current_user && current_user.admin?) || (current_user && current_user.moderator?)
  end
end
