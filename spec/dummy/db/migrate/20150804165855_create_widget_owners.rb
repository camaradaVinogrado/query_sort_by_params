class CreateWidgetOwners < ActiveRecord::Migration
  def change
    create_table :widget_owners do |t|
      t.integer :widget_id
      t.integer :owner_id

      t.timestamps null: false
    end
    add_index :widget_owners, :widget_id
    add_index :widget_owners, :owner_id
  end
end
