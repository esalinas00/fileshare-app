require 'http'

# Wake up API Server
class APIServerWakeUp
  def self.call()
    response = HTTP.get("#{ENV['API_HOST']}")
    response.code == 200 ? true : false
  end
end
