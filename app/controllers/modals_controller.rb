class ModalsController < ApplicationController
  skip_before_action :assign_users_for_connect

  layout 'modal'
end
