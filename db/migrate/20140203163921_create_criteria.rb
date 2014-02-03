class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.references :category, index: true
      t.text :name

      t.timestamps
    end
  end
end
