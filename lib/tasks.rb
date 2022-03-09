require 'telegram/bot'
require_relative 'bot'
require 'json'

class Tasks
  attr_accessor :task

  def initialize
    @task = request
  end

  def request
    file = File.read('data/tasks.json')
    response = JSON.parse(file)
    response
  end

  def random
    @task.sample
  end
end

# Tasks.new.request