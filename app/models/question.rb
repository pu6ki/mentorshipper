class Question < ApplicationRecord
  include Writable

  belongs_to :team
  belongs_to :technology

  validates :title, presence: true, length: { minimum: 5, maximum: 256 }

  has_many :answers

  def solved?
    answers.select(&:solving).count > 0
  end
end
