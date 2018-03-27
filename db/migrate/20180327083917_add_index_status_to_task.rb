class AddIndexStatusToTask < ActiveRecord::Migration[5.1]
  def change
    add_index :tasks, :status
  end
end
