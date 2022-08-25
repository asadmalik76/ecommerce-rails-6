# frozen_string_literal: true

# Cetegory Policy Definition
class CategoryPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    athorize_user?
  end

  def show?
    athorize_user?
  end

  def create?
    athorize_user?
  end

  def new?
    athorize_user?
  end

  def update?
    athorize_user?
  end

  def edit?
    athorize_user?
  end

  def destroy?
    athorize_user?
  end

  private

  def athorize_user?
    user.has_role? :seller
  end

  # Category Policy Scope
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
