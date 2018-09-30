class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :get_project_issues]
  before_action :set_url, only: [:create]

  def index
    projectsrepos = []
    @projects = Project.all
    projectsrepos = @projects.pluck(:repo).map do |repo|
      res = JSON.parse(GithubConnection.get_project_repo(repo).body)
      {:name => res["name"], :repo => res["owner_url"]}
    end
    json_response(projectsrepos)
  end

  def get_project_issues
    project_issues = []
    cards_url = @project.repo.sub(@project.number.to_s, "columns/#{@project.number}/cards")
    res = JSON.parse(GithubConnection.get_project_cards(cards_url).body)
    res.each do |card|
      if card.content_url.include? "/issues/"
        project_issues.push(card)
      end
    end

    project_issues
  end

  def create
    @project = Project.create!(project_params)
    res = JSON.parse(GithubConnection.create(@url, project_params).body)
    update_project(:repo => res["url"], :number => res["id"])
    json_response(@project, :created)
  end

  def update
    project_url = @project.repo
    @project = update_project(project_params)
    res = JSON.parse(GithubConnection.update(project_url, project_params).body)
    json_response(res)
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
