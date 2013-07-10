class AddDescriptionFieldToProcedures < ActiveRecord::Migration
  def up
  	add_column :procedures, :description, :text, default: ""
  end

  def down
  	remove_column :procedures, :description
  end
end
