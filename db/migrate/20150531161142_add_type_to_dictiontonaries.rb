class AddTypeToDictiontonaries < ActiveRecord::Migration
  def change
    add_column :dictionaries, :obj_type, :string
  end
end
