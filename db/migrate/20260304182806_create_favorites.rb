class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, [ :user_id, :book_id ], unique: true, if_not_exists: true
  end
end
