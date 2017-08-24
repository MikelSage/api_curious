class User < ApplicationRecord
  def self.update_or_create(auth)
    info = auth[:info]
    where(uid: auth[:uid]).first_or_initialize.tap do |user|
      user.name = info[:name]
      user.nickname = info[:nickname]
      user.email = info[:email]
      user.token = auth[:credentials][:token]
      user.provider = auth[:provider]
      user.image_url = info[:image]
      user.save!
    end
  end
end
