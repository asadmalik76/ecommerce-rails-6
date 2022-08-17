class Order < ApplicationRecord
  enum status: %i[draft pending processing delivered]
  # attribute :status, :integer, default: 'draft'
  belongs_to :user
  has_many :order_items
  before_create :add_order_id

  def add_order_id
    self.order_id = 4.times.map { rand(65..90).chr }.join.to_s + 8.times.map { rand(0..10) }.join.to_s
  end
end
