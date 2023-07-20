class AssociationTripArticleAndTag < ApplicationRecord
  belongs_to :trip_article
  belongs_to :tag
end
