class Room < ApplicationRecord
	has_many :messages

	belongs_to :user

	validates :name, presence: true, length: { maximum: 16 }
	validates :user_id, presence: true
end
