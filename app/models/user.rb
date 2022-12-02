class User < ApplicationRecord
  require "image_processing/mini_magick"
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post
  has_many :likes,
    dependent: :destroy
  has_many :comments
  has_one_attached :avatar

end
