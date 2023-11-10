class Category < ApplicationRecord
  has_many :drinks, dependent: :destroy
end
