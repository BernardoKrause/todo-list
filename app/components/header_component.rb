# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  def user_signed_in?
    helpers.user_signed_in?
  end
end
