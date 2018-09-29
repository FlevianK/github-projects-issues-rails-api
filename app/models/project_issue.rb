class ProjectIssue < ApplicationRecord
  belongs_to :issue
  belongs_to :project
end
