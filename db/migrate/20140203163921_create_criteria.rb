class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.references :category, index: true
      t.text :name
      t.boolean :higher_good

      t.timestamps
    end
  end
end
