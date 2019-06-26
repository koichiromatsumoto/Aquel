class Contact < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :reply, length: { maximum: 200 }
end
