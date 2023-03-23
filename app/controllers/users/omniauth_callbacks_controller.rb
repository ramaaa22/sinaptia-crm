# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :auth
  def google_oauth2
    omniauth_authentication
  end

  private

  def omniauth_authentication
    @identity = Identity.find_or_create_by uid: @auth["uid"], provider: @auth["provider"]

    @identity.update auth_data: @auth.as_json

    if signed_in?
      if @identity.user == current_user
        redirect_to root_path, notice: t(".already_linked")
      else
        @identity.update user: current_user
        redirect_to root_path, notice: t(".successfully_linked")
      end
    elsif @identity.user.blank?
      @user = User.find_or_initialize_by email: @auth.dig("info", "email")
      @user.validate
      if @user.errors[:email].any?
        redirect_to root_path, notice: t(".successfully_linked") and return
      end
      @user.update(first_name: @auth.dig("info", "first_name"), last_name: @auth.dig("info", "last_name"), password: Devise.friendly_token[0, 20]) if @user.new_record?

      @identity.update user: @user

      sign_in @identity.user
      redirect_to root_path
    else
      sign_in_and_redirect @identity.user
    end
  end

  def auth
    @auth ||= request.env["omniauth.auth"]
  end
end
