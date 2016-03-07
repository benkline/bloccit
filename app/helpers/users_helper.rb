module UsersHelper
  def user_has(x)
    (x.to_a).first == nil
  end
end
