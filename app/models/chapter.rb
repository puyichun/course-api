class Chapter < ApplicationRecord
  belongs_to :course
  has_many :units,-> { order(position: :asc) }, dependent: :destroy
  validates :name, presence: true
  acts_as_list scope: :course
end
