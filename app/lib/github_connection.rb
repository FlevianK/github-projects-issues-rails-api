require 'net/http'
require "uri"

module GithubConnection
  URL = "https://api.github.com/repos/#{ENV["GITHUB_USERNAME"].to_s}/rails-api"

  def self.create(url, params)
    http_method = "Post"
    make_request(http_method, url, params)
  end

  def self.update(url, params)
    http_method = "Patch"
    make_request(http_method, url, params) 
  end

  def self.get(url)
    http_method = "Get"
    make_request(http_method, url)
  end

  def self.delete(url)
    http_method = "Delete"
    make_request(http_method, url)
  end

  def self.make_request(http_method, url, params=nil)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    req = "Net::HTTP::#{http_method.capitalize}".constantize.new(uri.request_uri)
    req.basic_auth(ENV["GITHUB_USERNAME"], ENV["GITHUB_PASSWORD"])
    req["Accept"] = "application/vnd.github.inertia-preview+json"
    req.body = params.to_json if params
    http.request(req) 
  end
end