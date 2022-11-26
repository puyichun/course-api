class Unit < ApplicationRecord
  
  belongs_to :chapter

  validates :name, :content, presence: true

  acts_as_list scope: :chapter
  # 使用acts_as_list 紀錄其順序:position
end
