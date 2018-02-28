class Question < ApplicationRecord
  include Writable

  belongs_to :team
  belongs_to :technology

  validates :title, presence: true, length: { minimum: 5, maximum: 256 }

  has_many :answers

  default_scope { order(created_at: :desc) }

  def solved?
    answers.select(&:solving).count > 0
  end

  class << self
    def from_technology(technology_name)
      select { |q| q.technology.name == technology_name }
    end
  end
end
