class AddFiscalToTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :tables, :fiscal, foreign_key: { to_table: :users }
  end
end
