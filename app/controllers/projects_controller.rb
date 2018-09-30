class ProjectsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_url

  def index
    @projects = Project.all
    json_response(@projects)
  end

  def create
    res = JSON.parse(GithubConnection.create(@url, project_params).body)
    project = {:project => res["id"], :repo => res["html_url"]}
    @project = Project.create!(project)
    json_response(@project, :created)
  end

  def update
    @project.update(project_params)
    json_response(@project, :updated)
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
end
