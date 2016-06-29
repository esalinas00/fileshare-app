require 'http'

class CreatePublicKey
  def self.call(owner:, pk_data:)
    response = HTTP.post("#{ENV['API_HOST']}/accounts/#{owner['id']}/folders",
                         json: { pk_data: pk_data })
    pk = response.parse
    response.code == 201 ? pk : nil
  end
end
