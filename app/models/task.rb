class Task < ApplicationRecord
  belongs_to :list, optional: true
  enum priority: { baixa: 0, media: 1, alta: 2 }
  scope :by_priority, -> { order(concluido: :asc, priority: :desc) }
  validates :description, presence: true
end
