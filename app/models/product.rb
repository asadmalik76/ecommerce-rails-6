# frozen_string_literal: true

# Product Active Record
class Product < ApplicationRecord
  enum status: %i[available outofstock draft]
  belongs_to :category
  belongs_to :brand
  belongs_to :user
  has_many :order_items
  has_one_attached :main_image
  has_many_attached :images
  has_many :comments
  validates :description, length: { minimum: 50, message: ' must be greater than 50 characters' }
  validates :name, presence: true
  before_save :add_slug
  before_create :add_sku
  def add_sku
    self.sku = 4.times.map { rand(65..90).chr }.join.to_s + 8.times.map { rand(0..10) }.join.to_s
  end

  def add_slug
    self.slug = name.parameterize + id.to_s
  end
end
