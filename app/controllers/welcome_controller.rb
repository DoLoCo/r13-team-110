class WelcomeController < ApplicationController
  before_action :redirect_to_home
  def index; end;
private
  def redirect_to_home
    redirect_to home_index_url if user_signed_in?
  end
end