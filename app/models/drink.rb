class Drink < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :records, dependent: :destroy

  validates :name, presence: true, length: {maximum: 255}
  validates :degree, presence: true
  validates :volume, presence: true
end
