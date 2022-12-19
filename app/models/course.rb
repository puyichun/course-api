class Course < ApplicationRecord

  has_many :chapters, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true,, acceptance: { message: 'name must be abided' }

  validates :teacher, presence: true,, acceptance: { message: 'teacher must be abided' }
  
end
