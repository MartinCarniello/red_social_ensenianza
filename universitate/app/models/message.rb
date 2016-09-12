class Message < ApplicationRecord
  before_create :assign_conversation

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :conversation

  validates :sender_id, :receiver_id, :message, presence: true

  scope :sender, -> (sender) { where(sender: sender) }
  scope :order_recents, -> { order('created_at DESC') }

  private

  def assign_conversation
    self.conversation = if conversation = Conversation.members(sender, receiver).first
      conversation
    else
      Conversation.create(first_user: sender, second_user: receiver)
    end
  end
end