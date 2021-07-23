class CreateTestTables < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.timestamps
    end

    create_table :comments do |t|
      t.integer  :item_id
      t.timestamps
    end
  end
end
