class AddDefaultValueToAnswerSolvingAttribute < ActiveRecord::Migration[5.1]
  def change
    change_column :answers, :solving, :boolean, default: false
  end
end
