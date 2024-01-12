# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :drinks, dependent: :destroy
end
