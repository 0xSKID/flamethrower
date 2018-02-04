class CreatePerson < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :tinder_id
      t.string :name
      t.string :photos
      t.string :type

      t.integer :account_id

      t.timestamps
    end
    add_index :people, :account_id
  end
end
