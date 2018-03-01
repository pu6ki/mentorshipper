class Team < ApplicationRecord
  has_one :user, as: :userable, required: true

  validates :name, presence: true, length: { maximum: 500 }

  belongs_to :mentor

  has_many :questions

  def captain_email
    user.email
  end

  def to_s
    name
  end
end
