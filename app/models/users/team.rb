class Team < ApplicationRecord
  has_one :user, as: :userable, required: true

  validates :name, presence: true, length: { maximum: 500 }

  belongs_to :mentor

  has_many :posts
end
