class User < ApplicationRecord
  has_many :groups
  has_many :records
  validates :name, presence: true
end
