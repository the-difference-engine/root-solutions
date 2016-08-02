class Tag < ApplicationRecord
  has_many :subtags

  belongs_to :category
end
