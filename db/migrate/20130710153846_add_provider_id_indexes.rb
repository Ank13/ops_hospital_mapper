class AddProviderIdIndexes < ActiveRecord::Migration
  def change
    add_index :outcomes, :provider_id
    add_index :hospitals_procedures, :provider_id
    add_index :complications, :provider_id
    add_index :hospitals_procedures, :drg_id
    add_index :patient_surveys, :provider_id
    add_index :states_procedures, :drg_id
  end
end
