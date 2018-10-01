class Project < ApplicationRecord
  validates_presence_of :name, :body
end
