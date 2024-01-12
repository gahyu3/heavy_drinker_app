# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :drink
  belongs_to :user

  validates :date, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
