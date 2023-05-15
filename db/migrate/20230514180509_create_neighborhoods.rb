class CreateNeighborhoods < ActiveRecord::Migration[5.2]
  def change
    create_table :neighborhoods do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
