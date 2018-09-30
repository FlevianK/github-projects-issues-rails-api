class ProjectsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_url

  def index
    @projects = Project.all
    json_response(@projects)
  end

  def create
    @project = Project.create!(project_params)
    res = JSON.parse(GithubConnection.create(@url, project_params).body)
    update_project(:repo => res["owner_url"], :number => res["number"])
  end

  def update
    update_project(project_params)
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
    json_response(@project, :updated)
  end
end
