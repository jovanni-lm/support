class IssuesController < ApplicationController
  before_action :find_issue, only: [:show, :edit, :update, :destroy, :history]
  before_action :authenticate_staff!, only: :index

  def index
    if params[:filterrific] && (@query_issue = Issue.find_by(task_id: params[:filterrific][:search_query]))
      redirect_to @query_issue
    end

    @filterrific = initialize_filterrific(
      Issue,
      params[:filterrific],
      select_options: { with_status_id: Status.options_for_select }
    ) || return
    @issues = @filterrific.find.page(params[:page])
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.create(issue_params)
    respond_with @issue
  end

  def show
  end

  def edit
  end

  def update
    # Set status to the 'Waiting for Staff Response' for non staff customers.
    @issue.default_status unless staff_signed_in?

    @issue.update(issue_params)
    @issue.replies.build

    respond_with @issue
  end

  def destroy
    @issue.destroy
    respond_with @issue
  end

  def history
    @versions = @issue.versions
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :email, :body, :subject, :department,
                                  :staff_id, :status_id,
                                  replies_attributes: [:id, :answer])
  end

  def find_issue
    @issue = Issue.find_by(task_id: params[:id])
  end
end
