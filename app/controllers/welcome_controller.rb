class WelcomeController < ApplicationController
  before_action :redirect_to_themes_index
  def index; end;
private
  def redirect_to_themes_index
    redirect_to themes_url if user_signed_in?
  end
end