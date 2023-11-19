class AddVotationReferencesToPoliticiansParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :political_parties, :votation, foreign_key: true
  end
end
