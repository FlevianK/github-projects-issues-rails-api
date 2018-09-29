class Issue < ApplicationRecord
  has_many :project_issues
  has_many :projects, through: :project_issues
  validates_presence_of :issue
end
