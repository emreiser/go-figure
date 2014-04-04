class AddUnitToCriterion < ActiveRecord::Migration
  def change
    add_column :criteria, :unit, :text
  end
end
