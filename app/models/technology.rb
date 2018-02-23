class Technology < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 256 }

  has_and_belongs_to_many :users
  has_and_belongs_to_many :posts
end
