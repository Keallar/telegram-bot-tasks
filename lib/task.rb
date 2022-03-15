require 'telegram/bot'
require_relative 'bot'
require 'json'
require 'ruby-enum'

class Task
  include Ruby::Enum

  define :MATH, 'math'
  define :OTHER, 'other'

  attr_accessor :task, :answer, :question, :type

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

  def type_task
    Task.keys.sample
  end
end
