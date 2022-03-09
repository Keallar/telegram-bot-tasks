class CrateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks, force: true do |t|
      t.integer :id
    end
  end
end
