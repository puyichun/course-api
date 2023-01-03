class Course < ApplicationRecord

  has_many :chapters, -> { order(position: :asc) }, dependent: :destroy

  accepts_nested_attributes_for :chapters, allow_destroy: true

  validates :name, presence: true,, acceptance: { message: 'name must be abided' }

  validates :teacher, presence: true,, acceptance: { message: 'teacher must be abided' }
  
end
