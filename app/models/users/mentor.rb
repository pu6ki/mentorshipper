class Mentor < ApplicationRecord
  has_one :user, as: :userable, required: true

  has_many :teams

  def to_s
    user.to_s
  end
end
