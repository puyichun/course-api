class Unit < ApplicationRecord
  belongs_to :chapter
  validates :name, :content, presence: true
end
