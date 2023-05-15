class CreateDniTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :dni_types do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true
      
      t.timestamps
    end
    add_index :dni_types, :name, unique: true
  end
end
