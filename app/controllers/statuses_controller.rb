class StatusesController < ApplicationController
  before_action :prepare_new_status, only: [:new, :index]
  before_action :find_status, only: [:show, :edit, :update]
  before_action do
    unless current_staff && current_staff.admin?
      redirect_to root_path, alert: "You don't have permissions for this page"
    end
  end

  def index
    @statuses = Status.all
  end

  def new
  end

  def create
    @status = Status.create(status_params)
    respond_with @status, location: statuses_path
  end

  def show
  end

  def edit
  end

  def update
    @status.update(status_params)
    respond_with @status, location: statuses_path
  end

  private

  def status_params
    params.require(:status).permit(:title)
  end

  def prepare_new_status
    @status = Status.new
  end

  def find_status
    @status = Status.find(params[:id])
  end
end
