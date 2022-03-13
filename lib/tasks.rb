require 'telegram/bot'
require_relative 'bot'
require 'json'

class Tasks
  attr_accessor :task, :answer, :question

  def initialize
    @task = request
  end

  def request
    file = File.read('data/tasks.json')
    JSON.parse(file)
  end

  def random
    task = @task.sample
    @question = task['question']
    @answer = task['answer']
    { answer: @answer, question: @question }
  end
end
