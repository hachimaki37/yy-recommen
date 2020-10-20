class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.text :recommend_title
      t.integer :number
      t.decimal :total
      t.integer :user_id

      t.timestamps
    end
  end
end
