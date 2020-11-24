class Users::ModalsController < ApplicationController
  def sign_in_sign_up
    render layout: false
  end

  def sign_in
    render layout: false
  end

  def sign_up
    @user = User.new

    render layout: false
  end
end
