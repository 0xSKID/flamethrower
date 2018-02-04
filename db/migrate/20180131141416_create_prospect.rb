class CreateProspect < ActiveRecord::Migration[5.1]
  def change
    create_table :prospects do |t|
      t.string :tinder_id
      t.string :name
      t.string :photos
      t.string :phone_number
      t.boolean :match, default: false
      t.boolean :messaged_back, default: false
      t.boolean :date_scheduled, default: false
      t.boolean :liked, default: false
      t.boolean :passed, default: false

      t.integer :account_id

      t.timestamps
    end
    add_index :prospects, :account_id
  end
end
