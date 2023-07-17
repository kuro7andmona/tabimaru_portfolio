class CreateAssociationTripArticleandTags < ActiveRecord::Migration[6.1]
  def change
    create_table :association_trip_articleand_tags do |t|
      t.references :trip_articl, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
