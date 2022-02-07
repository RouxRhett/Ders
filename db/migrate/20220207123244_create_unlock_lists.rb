class CreateUnlockLists < ActiveRecord::Migration[5.2]
  def change
    create_table :unlock_lists do |t|
      t.integer   :user_id,             null: false
      t.integer   :achievement_id,      null: false

      t.timestamps
    end
  end
end
