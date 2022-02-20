class AddUnitToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :unit, :string
  end
end
