class WelcomeController < ApplicationController
    
    skip_before_action :authenticate_user!

  def sign_up
  end
end
