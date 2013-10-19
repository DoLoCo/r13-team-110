class Api::UsersController < Api::BaseController

  def search
    respond_with @users = User.search(params[:email])   
  end

end