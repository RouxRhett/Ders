class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.integer   :user_id,             null: false
      t.integer   :category_id,         null: false
      t.string    :goal,                null: false
      t.text      :reason,              null: false
      t.date      :deadline,            null: false
      t.boolean   :completion_status,   null: false,  default: false
      t.boolean   :public_status,       null: false,  default: true

      t.timestamps
    end
  end
end
