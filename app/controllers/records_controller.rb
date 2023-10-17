class RecordsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: 'Access denied'
  end

  def index
    @group = Group.find(params[:group_id])
    @records = @group.records.order(created_at: :desc).limit(50)
  end

  def new
    @record = Record.new
    @group = Group.find(params[:group_id])
    @groups = Group.where(user_id: current_user)
  end

  def create
    if params[:record][:group_ids].nil?
      flash.now[:notice] = 'Select a group'
      redirect_to request.referrer
    else
      @record = Record.new(record_params)
      @record.user = current_user

      if @record.save
        params[:record][:group_ids].each do |group_id|
          group = Group.find(group_id)
          @record.groups << group unless @record.groups.include?(group)
        end
        flash[:notice] = 'Record created!'
        redirect_to group_records_path(params[:record][:group_ids].first)
      else
        flash.now[:notice] = @record.errors.full_messages.join(', ')
        redirect_to request.referrer
      end
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to group_records_path(params[:group_id]), notice: 'Record deleted.'
  end

  protected

  def record_params
    params.require(:record).permit(:name, :amount, group_ids: [])
  end
end
