# frozen_string_literal: true

# Products Authorization policy for the user
class CommentPolicy
  attr_reader :user, :record, :product

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?; end

  def show?
    true
    # !Comment.find_by(product_id: @record.product_id, user_id: @user.id).present?
  end

  def create?
    authorize_seller?
  end

  def new?
    authorize_user?
  end

  def update?
    authorize_user?
  end

  def edit?
    authorize_user?
  end

  def destroy?
    authorize_user?
  end

  private

  def authorize_seller?
    !user.has_role? :seller and record.user == user
  end

  def authorize_user?
    record.user == user
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
