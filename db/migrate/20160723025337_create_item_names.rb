class CreateItemNames < ActiveRecord::Migration
  def change
    create_table :item_names do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
