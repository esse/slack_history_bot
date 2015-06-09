class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :channel
      t.string :user
      t.text :message
      t.string :team
      t.string :ts

      t.timestamps null: false
    end
  end
end
