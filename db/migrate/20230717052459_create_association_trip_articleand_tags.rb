class CreateAssociationTripArticleandTags < ActiveRecord::Migration[6.1]
  def change
    create_table :association_trip_article_and_tags do |t|
      t.references :trip_article, null: false, foreign_key: true
      t.integer :tag_id, null: false
      t.integer :tag_type, null: false
      t.timestamps
    end
  end
end
