class NavigationController < ApplicationController
  def index
    if !current_user.nil?
      @user = current_user
      render '../views/user/pantry.html.erb'
    end
  end
end
