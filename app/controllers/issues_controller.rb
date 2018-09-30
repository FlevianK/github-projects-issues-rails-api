class IssuesController < ApplicationController
  before_action :set_issue, only: [:update]
  before_action :set_url

  def create
    res = JSON.parse(GithubConnection.create(@url, issue_params).body)
    issue = {:issue => res["id"]}
    @issue = Issue.create!(issue)
    json_response(@issue, :created)
  end

  def update
    @issue.update(issue_params)
    json_response(@issue, :updated)
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :body)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def set_url
    @url = "#{GithubConnection::URL}/issues"
  end
end
