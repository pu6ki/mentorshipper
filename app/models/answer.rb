class Answer < ApplicationRecord
  include Writable

  belongs_to :mentor
  belongs_to :question

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }
  tracked recipient: Proc.new { |controller, model| model.question.team.user }
end
