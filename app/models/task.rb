class Task < ApplicationRecord
  belongs_to :list, optional: true
  validates :description, presence: true
end
