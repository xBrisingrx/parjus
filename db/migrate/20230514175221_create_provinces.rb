class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :provinces, :name, unique: true
  end
end
