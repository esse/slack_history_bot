class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.string :uid
      t.string :value

      t.timestamps null: false
    end
  end
end
