class AddTotalCostIndexToHospitals < ActiveRecord::Migration
   def change
    add_column :hospitals, :total_cost_index, :integer
  end
end
