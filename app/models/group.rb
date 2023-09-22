class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :records
  validates :name, presence: true, length: { maximum: 70 }
  validates :icon, presence: true
  validates_uniqueness_of :name, scope: :user_id

  def total_amount
    records.sum(:amount)
  end
end
