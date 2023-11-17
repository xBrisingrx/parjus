class CreateVotations < ActiveRecord::Migration[5.2]
  def change
    create_table :votations do |t|
      t.string :name, null: :false
      t.date :date, null: :false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
