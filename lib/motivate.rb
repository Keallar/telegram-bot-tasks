require 'net/http'
require 'json'

class Motivate
  attr_accessor :motivate

  def initialize
    @motivate = request
  end

  def request
    url = 'https://type.fit/api/quotes'
    uri = URI(url)
    str_response = Net::HTTP.get(uri)
    response = JSON.parse(str_response)
    response
  end

  def random
    @motivate.sample
  end
end
