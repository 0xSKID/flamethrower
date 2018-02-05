class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :tinder_id
      t.string :to_tinder_id
      t.string :from_tinder_id
      t.string :text
      t.string :type
      t.datetime :tinder_timestamp

      t.timestamps
    end
  end
end
