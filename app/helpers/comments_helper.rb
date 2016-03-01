module CommentsHelper
  def user_is_authorized_for_comment?(comment)
        current_user && (current_user == comment.user || current_user.admin?)
  end

  def from_post
    request.original_url.include? 'posts'
  end
end
