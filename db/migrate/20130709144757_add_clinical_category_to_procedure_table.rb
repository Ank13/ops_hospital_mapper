class AddClinicalCategoryToProcedureTable < ActiveRecord::Migration
  def up
  	add_column :procedures, :clinical_category, :string, default: ""
  end

  def down
  	remove_column :procedures, :clinical_category
  end
end
