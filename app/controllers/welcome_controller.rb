class WelcomeController < ApplicationController
  before_action :redirect_to_themes_index
  def index; end;


  def guest
    user = User.where(:email => 'guest@test.com').limit(1).first
    sign_in(:user, user)
    redirect_to themes_url
  end

private
  def redirect_to_themes_index
    redirect_to themes_url if user_signed_in?
  end
end