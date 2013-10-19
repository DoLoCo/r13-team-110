class ThemesController < ApplicationController
  respond_to :html
  
  before_action :load_theme, only: [:show]

  def show
    respond_with @theme
  end

  def new
    respond_with @theme = Theme.new
  end

  def create
    @theme = Theme.new(permitted_params.theme)
    respond_with @theme
  end

private

  def load_theme
    @theme = Theme.find(params[:id])
  end

end