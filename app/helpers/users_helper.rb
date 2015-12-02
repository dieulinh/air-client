module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
  end

  def omniauth_authorize_path(resource_name, provider)
    send "#{resource_name}_omniauth_authorize_path", provider
  end
end