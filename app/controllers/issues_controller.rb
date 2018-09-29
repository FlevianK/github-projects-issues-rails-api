class IssuesController < ApplicationController
  def create
    @issue = Issue.create!(issue_params)
    json_response(@issue, :created)
  end

  private

  def issue_params
    params.require(:issue).permit(:issue)
  end
end
