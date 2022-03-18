require 'rufus-scheduler'
require_relative '../lib/request'

scheduler = Rufus::Scheduler.new

scheduler.every '3s' do
  Request.send_task
end

scheduler.join