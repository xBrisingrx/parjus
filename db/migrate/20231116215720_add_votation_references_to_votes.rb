class AddVotationReferencesToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :votation, foreign_key: true
  end
end
