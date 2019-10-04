# Migration to create table for items
class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :text, null: false
      t.boolean :checked

      t.timestamps
    end
  end
end
