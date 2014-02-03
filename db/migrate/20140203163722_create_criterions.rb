class CreateCriterions < ActiveRecord::Migration
  def change
    create_table :criterions do |t|
      t.references :catgories, index: true
      t.text :name

      t.timestamps
    end
  end
end
