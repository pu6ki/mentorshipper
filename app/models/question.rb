class Question < ApplicationRecord
  belongs_to :team
  belongs_to :technology

  validates :title,   presence: true, length: { minimum: 5, maximum: 256 }
  validates :content, presence: true, length: { minimum: 5 }

  # has_and_belongs_to_many :technologies
  # validates :technologies, presence: true
end
