class CreateHeadquarterAffiliateds < ActiveRecord::Migration[5.2]
  def change
    create_table :headquarter_affiliateds do |t|
      t.references :headquarter, foreign_key: true
      t.references :person, foreign_key: true
      t.references :affiliated_rol, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
