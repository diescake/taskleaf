class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_atto_mark

  scope :recent, -> { order(created_at: :desc) }

  private

  def validate_name_not_including_atto_mark
    errors.add(:name, 'に＠を含めることはできません。') if name&.include?('@')
  end

  belongs_to :user
end
