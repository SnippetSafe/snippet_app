class Popovers::UsersController < ApplicationController
  def index
    @popover_options = current_user.popover_options

    render partial: 'shared/popover', layout: false, formats: [:html]
  end
end
