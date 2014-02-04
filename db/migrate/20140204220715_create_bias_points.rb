class CreateBiasPoints < ActiveRecord::Migration
  def change
    create_table :bias_points do |t|
      t.references :answer, index: true
      t.references :country, index: true
      t.boolean :positive

      t.timestamps
    end
  end
end
