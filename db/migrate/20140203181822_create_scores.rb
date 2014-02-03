class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :criterion, index: true
      t.references :country, index: true
      t.decimal :score

      t.timestamps
    end
  end
end
