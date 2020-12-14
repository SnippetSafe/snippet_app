class Modals::UsersController < ModalsController
  def sign_in_sign_up; end

  def sign_in
    @user = User.new
  end

  def sign_up
    @user = User.new
  end

  def edit_avatar; end
end
