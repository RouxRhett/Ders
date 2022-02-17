class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer   :target_id,           null: false
      t.string    :name,                null: false
      t.integer   :time,                null: false,  default: 0

      t.timestamps
    end
  end
end
