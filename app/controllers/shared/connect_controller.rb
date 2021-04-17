class Shared::ConnectController < ApplicationController
  def index
    user_base = User
    
    if user_signed_in?
      user_base = user_base.not_followed_by(current_user)
    end

    @users_for_connect = user_base.order(Arel.sql('RANDOM()')).limit(3)
  end
end