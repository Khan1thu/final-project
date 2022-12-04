class User < ApplicationRecord
  require "image_processing/mini_magick"
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  has_many :post
  has_many :likes,
    dependent: :destroy
  has_many :comments
  has_one_attached :avatar

  def self.from_omniauth(auth)
    oauth_user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
        if auth.info.image
          downloaded_image = URI.open(auth.info.image)
          user.avatar.attach(io: downloaded_image,
          filename: "image-#{Time.now.strftime("%s%L")}",
          content_type: downloaded_image.content_type)
        end
      end
    end
      
    def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"] ||
          data = session["devise.github_data"] && session["devise.github_data"]["info"]
          user.name = data["name"] if user.name.blank?
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
