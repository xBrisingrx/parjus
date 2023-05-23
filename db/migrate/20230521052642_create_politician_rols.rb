class CreatePoliticianRols < ActiveRecord::Migration[5.2]
  def change
    create_table :politician_rols do |t|
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
