class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :tinder_id
      t.string :to_tinder_id
      t.string :from_tinder_id
      t.string :text
      t.string :type
      t.datetime :tinder_timestamp

      t.integer :person_id

      t.timestamps
    end
    add_index :messages, :person_id
  end
end
