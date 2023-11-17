class AddVotationReferencesToPoliticianRols < ActiveRecord::Migration[5.2]
  def change
    add_reference :politician_rols, :votation, foreign_key: true
  end
end
