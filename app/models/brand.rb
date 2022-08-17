# frozen_string_literal: true

# Brand model
class Brand < ApplicationRecord
  has_many :products
  validates :name, uniqueness: { message: 'Already exists' }
  before_save :add_slug

  def add_slug
    self.slug = name.parameterize
  end
end
