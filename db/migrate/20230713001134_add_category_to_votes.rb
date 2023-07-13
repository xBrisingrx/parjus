class AddCategoryToVotes < ActiveRecord::Migration[5.2]
  def change
  add_column :votes, :category, :integer, default: 0
  end
end
