require 'http'

# Returns all folders belonging to an account
class GetUserID
  def self.call(username:)
    response = HTTP.get("#{ENV['API_HOST']}/accounts/#{username}")
    response.code == 200 ? response.parse['id'] : nil
  end
end
