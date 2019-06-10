class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts
  has_many :favorites
  has_many :albums
  has_many :relationships
  has_many :rooms
  has_many :messages
  has_many :contacts
  has_many :contact_messages
end
