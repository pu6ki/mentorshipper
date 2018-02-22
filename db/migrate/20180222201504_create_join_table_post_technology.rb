class CreateJoinTablePostTechnology < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :technologies do |t|
      t.index [:post_id, :technology_id]
    end
  end
end
