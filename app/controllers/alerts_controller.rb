class AlertsController < ApplicationController
  skip_before_action :assign_users_for_connect

  layout 'alert'
end
