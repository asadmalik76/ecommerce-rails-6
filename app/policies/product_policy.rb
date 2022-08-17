# frozen_string_literal: true

# Products Authorization policy for the user
class ProductPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.has_role? :seller
  end

  def show?
    false
  end

  def create?
    authorize_seller?
  end

  def new?
    authorize_seller?
  end

  def update?
    authorize_seller?
  end

  def edit?
    authorize_seller?
  end

  def destroy?
    user.has_role? :seller
  end

  private

  def authorize_seller?
    user.has_role? :seller and record.user == user
  end

  # Scope class
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
