class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :get_project_issues, :delete]
  before_action :set_url, only: [:create]

  def index
    @projects = Project.all
    projectsrepos = @projects.pluck(:repo).map do |repo|
      res = JSON.parse(GithubConnection.get(repo).body)
      {:name => res["name"], :repo => res["owner_url"]}
    end
    json_response(projectsrepos)
  end

  def get_project_issues
    columns_url = "#{@project.repo}/columns"
    project_columns = JSON.parse(GithubConnection.get(columns_url).body)
    cards = project_columns.map do |column|
      JSON.parse(GithubConnection.get(column["cards_url"]).body)
    end
    project_issues = cards.flatten.select do |card|
      card["content_url"] && card["content_url"].include?("/issues/")
    end

    json_response(project_issues)
  end

  def create
    @project = Project.create!(project_params)
    created_project = GithubConnection.create(@url, project_params)
    res = JSON.parse(created_project.body)
    update_project(:repo => res["url"], :number => res["id"])
    json_response(@project, :created)
  end

  def update
    project_url = @project.repo
    @project = update_project(project_params)
    res = JSON.parse(GithubConnection.update(project_url, project_params).body)
    json_response(res)
  end

  def delete
    project_url = @project.repo
    @project.destroy
    GithubConnection.delete(project_url)
  end

  private

  def project_params
    params.require(:project).permit(:name, :body)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_url
    @url = "#{GithubConnection::URL}/projects"
  end

  def update_project(updated_params)
    @project.update(updated_params)
  end
end
