class AddVotationReferencesToPoliticiansParties < ActiveRecord::Migration[5.2]
  def change
    add_reference :politicians_parties, :votation, foreign_key: true
  end
end
