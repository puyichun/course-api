class Chapter < ApplicationRecord
  
  belongs_to :course
  has_many :units,-> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :units, allow_destroy: true

  validates :name, presence: true, acceptance: { message: 'name must be abided' }

  acts_as_list scope: :course
  # 使用acts_as_list 紀錄其順序:position
end
