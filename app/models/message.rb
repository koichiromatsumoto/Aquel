class Message < ApplicationRecord
	belongs_to :user
	belongs_to :room

	validates :content, presence: true, length: { maximum: 100 }
	validates :user_id, presence: true

	# messageがcreateされた後にMessageBroadcastJobのperformを遅延実行 引数はself
	after_create_commit { MessageBroadcastJob.perform_later self }
end
