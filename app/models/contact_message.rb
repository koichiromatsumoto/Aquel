class ContactMessage < ApplicationRecord
  belongs_to :contact
  belongs_to :user
end
