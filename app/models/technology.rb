class Technology < ApplicationRecord
  validates :name, presence: true, length: { maximum: 256 }

  has_and_belongs_to_many :users
end
