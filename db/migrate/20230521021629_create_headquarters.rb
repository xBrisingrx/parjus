class CreateHeadquarters < ActiveRecord::Migration[5.2]
  def change
    create_table :headquarters do |t|
      t.string :name, null: false
      t.text :description
      t.references :neighborhood, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
