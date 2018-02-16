class Mentor < ApplicationRecord
  has_one :user, as: :userable, required: true

  has_many :teams
end
