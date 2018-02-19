class CreateJoinTableUserTechnology < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :technologies do |t|
      t.index [:user_id, :technology_id]
    end
  end
end
