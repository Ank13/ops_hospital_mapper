class AddIndexToProviderId < ActiveRecord::Migration
  def change
  	add_index :hospitals, :provider_id
  end
end
