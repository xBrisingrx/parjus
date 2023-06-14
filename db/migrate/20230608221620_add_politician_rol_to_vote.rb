class AddPoliticianRolToVote < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :politician_rol, foreign_key: true
  end
end
