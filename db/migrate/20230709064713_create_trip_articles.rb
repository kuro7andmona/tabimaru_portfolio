class CreateTripArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :trip_articles do |t|
      t.integer :user_id
      t.string :title
      t.text :text
      t.timestamps
    end
  end
end
