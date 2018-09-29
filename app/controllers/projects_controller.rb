class ProjectsController < ApplicationController
  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  private

  def project_params
    params.require(:project).permit(:project, :repo)
  end
end
