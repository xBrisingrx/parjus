class CreateInstitutionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :institution_types do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
