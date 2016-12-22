class Citation < ApplicationRecord
  belongs_to :resource
  belongs_to :news_source, optional: true
end
