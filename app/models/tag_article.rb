class TagArticle < ActiveRecord::Base
  belongs_to :article
  belongs_to :tag
end
