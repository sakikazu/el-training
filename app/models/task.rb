class Task < ApplicationRecord
  include AASM

  has_many :task_labels
  has_many :labels, through: :task_labels

  # NOTE: aasmでstatusに初期値がセットされてしまうため、別カラムを設けるハメになった
  # ベストはTaskSearcherモデルを作成すること
  attr_accessor :status_for_search, :labels_text

  after_save :create_labels

  validates :name, presence: true
  validate :future_expired_on

  enum status: {
    waiting: 0,
    working: 1,
    completed: 2
  }

  enum priority: {
    低: 0,
    中: 1,
    高: 2
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

  def create_labels
    labels_text.split(",").each do |label_name|
      label = Label.find_or_create_by(name: label_name)
      tl = self.task_labels.where(label_id: label.id)
      self.task_labels.create(label: label) if tl.blank?
    end
  end

  def future_expired_on
    errors.add(:expired_on, I18n.t('errors.messages.past_date')) if expired_on < Date.today
  end
end
