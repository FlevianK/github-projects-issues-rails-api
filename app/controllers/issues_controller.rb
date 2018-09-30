class IssuesController < ApplicationController
  before_action :set_issue, only: [:update]
  before_action :set_url, only: [:create]

  def create
    @issue = Issue.create!(issue_params)
    res = JSON.parse(GithubConnection.create(@url, issue_params).body)
    update_issue(:repo => res["url"], :number => res["number"])
    json_response(@issue, :created)
  end

  def update
    issue_url = @issue.repo
    @issue = update_issue(issue_params)
    res = JSON.parse(GithubConnection.update(issue_url, issue_params).body)
    json_response(res)
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

  def update_issue(updated_params)
    @issue.update(updated_params)
  end
end
