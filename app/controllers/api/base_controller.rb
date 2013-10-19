class Api::BaseController < AuthenticatedController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: [], status: :not_found
  end

  respond_to :json
end