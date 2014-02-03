class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.text :name
      t.integer :hdi_rank
      t.boolean :select

      t.timestamps
    end
  end
end
