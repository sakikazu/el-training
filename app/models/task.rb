class Task < ApplicationRecord
  include AASM

  validates :name, presence: true
  validate :future_expired_on

  enum status: {
    waiting: 0,
    working: 1,
    completed: 2
  }

  aasm column: :status, enum: true do
    state :waiting, initial: true
    state :working
    state :completed
  end

  private

  def future_expired_on
    errors.add(:expired_on, I18n.t('errors.messages.past_date')) if expired_on < Date.today
  end
end
