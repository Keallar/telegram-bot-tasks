require 'active_record'

class CreateMotivate < ActiveRecord::Migration[6.1]
  def change
    create_table :motivate do |t|
      return if table_exits?

      t.string :text
      t.string :author
    end
  end

  def table_exits?
    ActiveRecord::Base.connection.table_exists?(:motivate)
  end
end
