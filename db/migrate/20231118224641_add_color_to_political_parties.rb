class AddColorToPoliticalParties < ActiveRecord::Migration[5.2]
  def change
    add_column :political_parties, :color, :string, default: "#aae0fa"
  end
end
