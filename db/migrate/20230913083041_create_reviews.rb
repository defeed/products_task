class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :product, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
