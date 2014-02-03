class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :country_1_id
      t.integer :country_2_id
      t.references :criterion
      t.integer :selected_country_id
      t.boolean :correct
      t.boolean :positive

      t.timestamps
    end
  end
end
