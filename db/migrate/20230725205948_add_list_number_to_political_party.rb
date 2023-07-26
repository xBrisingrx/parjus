class AddListNumberToPoliticalParty < ActiveRecord::Migration[5.2]
  def change
    add_column :political_parties, :list, :integer
  end
end
