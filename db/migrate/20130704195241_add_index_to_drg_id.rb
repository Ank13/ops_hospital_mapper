class AddIndexToDrgId < ActiveRecord::Migration
  def change
    add_index :procedures, :drg_id
  end
end
