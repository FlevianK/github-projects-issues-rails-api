require 'net/http'
require "uri"

module GithubConnection
  URL = "https://api.github.com/repos/FlevianK/rails-api"

  def self.create(url, params)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = Net::HTTP::Post.new(uri.request_uri)
    req.basic_auth("FlevianK", ENV["GITHUB_PASSWORD"])
    req["Accept"] = "application/vnd.github.inertia-preview+json"
    req.body = params.to_json
    http.request(req) 
  end
end