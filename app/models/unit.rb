class Unit < ApplicationRecord
  belongs_to :chapter
  validates :name, :content, presence: true
  acts_as_list scope: :chapter
end
