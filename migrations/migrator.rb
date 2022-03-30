require_relative './create_tasks'
require_relative './create_motivate'

class Migrator
  def migrate
    CreateTasks.new.change
    CreateMotivate.new.change
  end
end
