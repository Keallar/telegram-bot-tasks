require 'active_record'
require 'pg'

namespace :db do
  db_connector = {
    host: 'localhost',
    adapter: 'postgresql'
  }
  # Create Database
  desc 'Create Database'
  task :create do
    new_db_name = 'active_record'
    ActiveRecord::Base.establish_connection(db_connector)
    db_create = ActiveRecord::Base.connection.create_database(new_db_name, {
      template: 'template0',
      encoding: 'unicode'
    })

    puts "Database #{new_db_name} created." if db_create
  end
  # Drop Database
  desc 'Drop Database'
  task :drop do
    ActiveRecord::Base.establish_connection(db_connector)
    db_drop = ActiveRecord::Base.connection.drop_database('active_record')

    puts 'Database dropped' if db_drop
  end

  # Migrate Database
  desc 'Migrate Database'
  task :migrate do
    require_relative './migrations/migrator'

    db_connector['database'] = 'active_record'
    ActiveRecord::Base.establish_connection(db_connector)

    db_migrate = Migrator.new.migrate
    puts 'Database migrations run successfully' if db_migrate
  end

  # Reset Database
  desc 'Reset the database'
  task :reset => [:drop, :create, :migrate]

end
