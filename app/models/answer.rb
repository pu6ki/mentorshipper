class Answer < ApplicationRecord
  include Writable
  include PublicActivity::Model

  belongs_to :mentor
  belongs_to :question

  default_scope { order(:solving, :created_at) }

  tracked owner:     proc { |controller, _| controller.current_user  }
  tracked recipient: proc { |_, model|      model.question.team.user }
end
