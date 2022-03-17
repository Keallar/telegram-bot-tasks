require 'whenever'
require_relative '../lib/request'

set :output, "log/cron_log.log"

every 1.minute do
  runner 'Request.send_task'
end
