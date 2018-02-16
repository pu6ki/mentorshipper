class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { maximum: 256 }
  validates :last_name,  presence: true, length: { maximum: 256 }

  belongs_to :userable, polymorphic: true, dependent: :destroy, required: false

  def full_name
    first_name + ' ' + last_name
  end
end
