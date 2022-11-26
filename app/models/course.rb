class Course < ApplicationRecord

  has_many :chapters, -> { order(position: :asc) }, dependent: :destroy

  validates :name, :teacher, presence: true
  
end
