class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name, null: false
      t.text :description
      t.string :direction, null: false
      t.boolean :active, default: true
      t.references :neighborhood, foreign_key: true
      t.references :institution_type, foreign_key: true

      t.timestamps
    end
  end
end
