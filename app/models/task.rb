class Task < ApplicationRecord
  include AASM

  # NOTE: aasmでstatusに初期値がセットされてしまうため、別カラムを設けるハメになった
  # ベストはTaskSearcherモデルを作成すること
  attr_accessor :status_for_search

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

  def self.search(params)
    records = self.all
    return records if params.blank?

    if params[:name].present?
      records = records.where("name like ?", "%#{params[:name]}%")
    end
    if params[:status_for_search].present?
      records = records.where(status: params[:status_for_search])
    end
    records
  end

  private

  def future_expired_on
    errors.add(:expired_on, I18n.t('errors.messages.past_date')) if expired_on < Date.today
  end
end
