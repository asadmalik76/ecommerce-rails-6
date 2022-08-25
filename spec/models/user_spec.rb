require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject { build(:user) }
    it do
      should { validate_presence_of(:first_name) }
      should { validate_presence_of(:last_name) }
      should { validate_presence_of(:email) }
      should { validate_uniqueness_of(:email).ignoring_case_sensitivity }
      should { validate_presence_of(:password).ignoring_case_sensitivity }
    end
  end

  it { is_expected.to callback(:set_full_name).before(:save) }
  it { is_expected.to callback(:set_default_avatar).before(:save) }

  context 'associations' do
    it do
      should have_many(:products)
      should have_many(:comments)
      should have_many(:orders)
      should have_one(:avatar_attachment)
      should have_one(:cart)
    end
  end
end
