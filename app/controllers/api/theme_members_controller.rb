class Api::ThemeMembersController < Api::BaseController
  load_and_authorize_resource :theme

  before_action :load_theme_member_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :theme_member, through: :theme

  def index
    respond_with @theme_members
  end

  def create
    respond_to do |format|
      if @theme_member.save
        Pusher["theme-#{@theme.id}"].trigger('member-create', ThemeMemberSerializer.new(@theme_member).to_json)
        format.json { render json: @theme_member }
      else
        format.json { render json: @theme_member.errors, status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    @theme_member.destroy
    Pusher["theme-#{@theme.id}"].trigger('member-remove', ThemeMemberSerializer.new(@theme_member).to_json)
    respond_with @theme_member
  end

private

  def load_theme_member_for_create
    @theme_member = @theme.theme_members.build(permitted_params.theme_member)
  end

end