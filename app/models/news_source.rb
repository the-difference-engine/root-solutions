class NewsSource < ApplicationRecord
  has_many :resources
  has_many :citations
end
