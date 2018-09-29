class ProjectsController < ApplicationController
  before_action :set_project, only: [:update]

  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  def update
    @project.update(project_params)
    json_response(@project, :updated)
  end

  private

  def project_params
    params.require(:project).permit(:project, :repo)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
