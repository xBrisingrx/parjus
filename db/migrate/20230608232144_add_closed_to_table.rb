class AddClosedToTable < ActiveRecord::Migration[5.2]
  def change
    add_column :tables, :closed, :boolean, default: false
  end
end
