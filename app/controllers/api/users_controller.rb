class Api::UsersController < Api::BaseController

  def search
    respond_with @users = User.by_email(params[:email]).limit(25)
  end

end