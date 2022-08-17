# frozen_string_literal: true

# Category ActiveRecord
class Category < ApplicationRecord
  has_many :products

  validates :name, uniqueness: { message: 'Already exists' }
  before_save :add_slug

  def add_slug
    self.slug = name.parameterize
  end
end
