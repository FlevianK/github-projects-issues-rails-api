class ApplicationController < ActionController::API
  include Response
  include GithubConnection
  include ExceptionHandler
end
