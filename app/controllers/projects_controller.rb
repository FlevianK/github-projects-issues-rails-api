class ProjectsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_url, only: [:create]

  def index
    @projects = Project.all
    json_response(@projects)
  end

  def create
    @project = Project.create!(project_params)
    res = JSON.parse(GithubConnection.create(@url, project_params).body)
    update_project(:repo => res["url"], :number => res["number"])
    json_response(@project, :created)
  end

  def update
    project_url = @project.repo
    @project = update_project(project_params)
    res = JSON.parse(GithubConnection.update(project_url, project_params).body)
    json_response(@project)
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
