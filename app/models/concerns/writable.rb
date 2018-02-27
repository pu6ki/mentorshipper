module Writable
  extend ActiveSupport::Concern

  included do
    # belongs_to :user

    validates :content, presence: true, length: { minimum: 5 }
  end
end
