require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations' do
    subject { build(:product) }
    it { should define_enum_for(:status).with_values(%i[available outofstock draft]) }
    it do
      should { validate_presence_of(:title) }
      should { validate_presence_of(:description) }
      should { validate_presence_of(:price) }
      should { validate_presence_of(:quantity) }
      should { validate_presence_of(:status) }
      should { validate_presence_of(:sku) }
      should { validate_uniqueness_of(:sku) }
      should { validate_presence_of(:slug) }
      should { validate_uniqueness_of(:slug) }
    end
  end

  it { is_expected.to callback(:add_slug).before(:save) }
  it { is_expected.to callback(:add_sku).before(:create) }

  context 'associations' do
    it do
      should belong_to(:category)
      should belong_to(:brand)
      should belong_to(:user)
      should have_many(:order_items)
      should have_one(:main_image_attachment)
      should have_many(:images_attachments)
      should have_many(:comments)
    end
  end
end
