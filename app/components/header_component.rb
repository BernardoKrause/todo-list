# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def initialize(current_user: :current_user)
    @current_user = current_user
  end

  def user_signed_in?
    helpers.user_signed_in?
  end

  def current_user
    helpers.current_user
  end
end
