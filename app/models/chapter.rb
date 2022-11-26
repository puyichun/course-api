class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units, dependent: :destroy
  validates :name, presence: true
  acts_as_list
end
