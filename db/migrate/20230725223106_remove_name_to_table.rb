class RemoveNameToTable < ActiveRecord::Migration[5.2]
  def up
    remove_column :tables, :name
  end

  def down
    add_column :tables, :name, :string
  end

end
