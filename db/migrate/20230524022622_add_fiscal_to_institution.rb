class AddFiscalToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_reference :institutions, :fiscal, foreign_key: { to_table: :users }
  end
end
