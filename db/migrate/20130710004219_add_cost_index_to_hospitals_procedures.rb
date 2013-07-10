class AddCostIndexToHospitalsProcedures < ActiveRecord::Migration
   def change
    add_column :hospitals_procedures, :cost_index, :integer
  end
end
