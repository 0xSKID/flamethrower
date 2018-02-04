class CreateRawData < ActiveRecord::Migration[5.1]
  def change
    create_table :raw_data do |t|
      t.integer :owner_id
      t.string :owner_type

      t.jsonb :data
      t.timestamps
    end
  end
end
