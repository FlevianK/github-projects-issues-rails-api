class IssuesController < ApplicationController
  before_action :set_issue, only: [:update]

  def create
    @issue = Issue.create!(issue_params)
    json_response(@issue, :created)
  end

  def update
    @issue.update(issue_params)
    json_response(@issue, :updated)
  end

  private

  def issue_params
    params.require(:issue).permit(:issue)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
