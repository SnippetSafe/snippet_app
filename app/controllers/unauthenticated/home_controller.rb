class Unauthenticated::HomeController < ApplicationController
	layout 'unauthenticated'

  def index
    @year = Date.today.year
  end
end