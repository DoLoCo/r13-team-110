class Api::GroupsController < Api::BaseController
  load_and_authorize_resource :theme

  before_action :load_group_for_create, only: :create # CanCan workaround
  load_and_authorize_resource :group, through: :theme

  def index
    respond_with @groups
  end

  def create
    respond_to do |format|
      if @group.save
        GroupPublisher.new(@theme, @group).publish_create!
        format.json { render json: @group }
      else
        format.json { render json: @group.errors }
      end
    end
  end

  def update
    if @group.update(permitted_params.group)
      GroupPublisher.new(@theme, @group).publish_update!
    end
    respond_with @group
  end

  def destroy
    @group.destroy
    GroupPublisher.new(@theme, @group).publish_destroy!
    respond_with @group
  end

private

  def load_group_for_create
    @group = @theme.groups.build
  end

end