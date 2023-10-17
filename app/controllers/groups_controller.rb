class GroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: 'Access denied'
  end

  def index
    @groups = Group.all.order(created_at: :desc).limit(50)
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id

    @group.icon = params[:icon]

    if @group.save
      flash[:notice] = 'Category created'
      redirect_to groups_path
    else
      @group.errors.full_messages
      flash[:notice] = @group.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def new
    @group = Group.new
    @icons = [
      'icons/01.png', 'icons/02.png', 'icons/03.png', 'icons/04.png', 'icons/05.png',
      'icons/06.png', 'icons/07.png', 'icons/08.png', 'icons/09.png', 'icons/10.png',
      'icons/11.png', 'icons/12.png', 'icons/13.png', 'icons/14.png', 'icons/15.png'
    ]
  end

  def destroy
    @group = Group.find(params[:id])
    @records = @group.records
    @records.destroy_all
    @group.destroy
  end

  protected

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
