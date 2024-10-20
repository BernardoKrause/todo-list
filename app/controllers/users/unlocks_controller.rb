# frozen_string_literal: true

class Users::UnlocksController < Devise::UnlocksController
  # GET /resource/unlock/new
  # def new
  #   super
  # end

  # POST /resource/unlock
  # def create
  #   super
  # end

  # GET /resource/unlock?unlock_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   super(resource)
  # end

  def create
    self.resource = resource_class.find_for_database_authentication(email: params[resource_name][:email])
    if resource&.locked?
      flash[:alert] = "Sua conta está bloqueada. Por favor, verifique seu e-mail para desbloquear."
      redirect_to new_user_session_path and return
    end

    super
  end
end
