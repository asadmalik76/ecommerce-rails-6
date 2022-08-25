# frozen_string_literal: true

# This class manages seller registrations and add seller roles
class SellersController < Users::RegistrationsController
  def create
    super
    resource.add_role :seller
  end

  private

  def after_sign_up_path_for(_resource)
    root_path
  end
end
