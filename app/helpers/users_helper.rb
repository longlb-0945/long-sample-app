module UsersHelper
  def gravatar_for user, options = {size: Settings.user_helper_gravatar}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def find_following id
    current_user.active_relationships.find_by followed_id: id
  end
end
