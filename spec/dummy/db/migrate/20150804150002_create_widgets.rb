class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.datetime :important_time

      t.timestamps null: false
    end
  end
end
