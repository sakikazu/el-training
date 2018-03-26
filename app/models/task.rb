class Task < ApplicationRecord
  validates :name, presence: true
  validate :future_expired_on

  private

  def future_expired_on
    errors.add(:expired_on, I18n.t('errors.messages.past_date')) if expired_on < Date.today
  end
end
