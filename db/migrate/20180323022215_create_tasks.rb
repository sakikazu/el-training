class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :priority
      t.date :expired_on
      t.integer :status

      t.timestamps
    end
  end
end
