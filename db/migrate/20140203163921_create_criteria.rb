class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.references :catgories, index: true
      t.text :name

      t.timestamps
    end
  end
end
