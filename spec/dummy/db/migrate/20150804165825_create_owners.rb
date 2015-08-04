class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :occupation

      t.timestamps null: false
    end
  end
end
