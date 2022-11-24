class Course < ApplicationRecord
  has_many :chapters, dependent: :destroy
  validates :name, :teacher, presence: true
end
