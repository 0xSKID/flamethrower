class CreateUpdate < ActiveRecord::Migration[5.1]
  def change
    create_table :updates do |t|
      t.integer :account_id

      t.timestamps
    end
    add_index :updates, :account_id
  end
end
