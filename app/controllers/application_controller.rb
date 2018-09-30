class ApplicationController < ActionController::API
  include Response
  include GithubConnection
end
