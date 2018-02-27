class Answer < ApplicationRecord
  include Writable

  belongs_to :mentor
  belongs_to :question
end
