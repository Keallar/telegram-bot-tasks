require 'active_record'

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      return if table_exits?

      t.string :question
      t.string :answer
    end
  end

  def table_exits?
    ActiveRecord::Base.connection.table_exists?(:tasks)
  end
end
