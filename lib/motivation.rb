require 'net/http'
require 'json'

class Motivation
  attr_accessor :motivate

  def initialize
    @motivate = request
  end

  def request
    url = 'https://type.fit/api/quotes'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def random
    @motivate.sample
  end
end

# Motivation.new.request
