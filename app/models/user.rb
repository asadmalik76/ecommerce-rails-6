# frozen_string_literal: true

# USer Active Record
class User < ApplicationRecord
  attr_accessor :first_name, :last_name

  before_save :set_full_name
  before_save :set_default_avatar
  has_many :products
  has_many :orders
  has_many :comments
  has_one_attached :avatar
  has_one :cart
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def set_full_name
    self.full_name = "#{@first_name} #{@last_name}"
  end

  def set_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'user.png')), filename: 'user.png',
                    content_type: 'image/png')
    end
  end

  # def first_name
  #   full_name.split(' ')[0]
  # end

  # def last_name
  #   full_name.split(' ')[1]
  # end

end
