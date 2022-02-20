class AddNumTgtToTarget < ActiveRecord::Migration[5.2]
  def change
    add_column :targets, :num_tgt, :integer
  end
end
