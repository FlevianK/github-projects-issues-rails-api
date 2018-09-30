class Project < ApplicationRecord
  has_many :project_issues
  has_many :issues, through: :project_issues
  validates_presence_of :name, :body
end
