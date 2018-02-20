class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true, length: { maximum: 256 }
  validates :last_name,  presence: true, length: { maximum: 256 }

  belongs_to :userable, polymorphic: true, dependent: :destroy, required: false

  has_and_belongs_to_many :technologies
  validates :technologies, presence: true

  def full_name
    first_name + ' ' + last_name
  end

  def mentor?
    userable_type == 'Mentor'
  end

  def team?
    userable_type == 'Team'
  end
end
